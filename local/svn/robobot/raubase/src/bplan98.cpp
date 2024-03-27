/*  
 * 
 * Copyright © 2023 DTU,
 * Author:
 * Christian Andersen jcan@dtu.dk
 * 
 * The MIT License (MIT)  https://mit-license.org/
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software
 * and associated documentation files (the “Software”), to deal in the Software without restriction, 
 * including without limitation the rights to use, copy, modify, merge, publish, distribute, 
 * sublicense, and/or sell copies of the Software, and to permit persons to whom the Software 
 * is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies 
 * or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
 * THE SOFTWARE. */

#include <string>
#include <string.h>
#include <math.h>
#include <unistd.h>
#include "mpose.h"
#include "steensy.h"
#include "uservice.h"
#include "sencoder.h"
#include "utime.h"
#include "cmotor.h"
#include "cservo.h"
#include "medge.h"
#include "cedge.h"
#include "cmixer.h"
#include "sdist.h"

#include "bplan98.h"

// create class object
BPlan98 plan98;


void BPlan98::setup()
{ // ensure there is default values in ini-file
  if (not ini["plan98"].has("log"))
  { // no data yet, so generate some default values
    ini["plan98"]["log"] = "true";
    ini["plan98"]["run"] = "false";
    ini["plan98"]["print"] = "true";
  }
  // get values from ini-file
  toConsole = ini["plan98"]["print"] == "true";
  //
  if (ini["plan98"]["log"] == "true")
  { // open logfile
    std::string fn = service.logPath + "log_plan98.txt";
    logfile = fopen(fn.c_str(), "w");
    fprintf(logfile, "%% Mission plan98 logfile\n");
    fprintf(logfile, "%% 1 \tTime (sec)\n");
    fprintf(logfile, "%% 2 \tMission state\n");
    fprintf(logfile, "%% 3 \t%% Mission status (mostly for debug)\n");
  }
  setupDone = true;
}

BPlan98::~BPlan98()
{
  terminate();
}

void BPlan98::run()
{
  if (not setupDone)
    setup();
  if (ini["plan98"]["run"] == "false")
    return;
  UTime t("now");
  bool finished = false;
  bool lost = false;
  state = 0;
  oldstate = state;
  const int MSL = 100;
  char s[MSL];
  //
  toLog("Plan98 started");
  //
  while (not finished and not lost and not service.stop)
  {
    switch (state)
    {
      case 0: //drive
        mixer.setEdgeMode(true, 0);
        mixer.setVelocity(0.25);
        state = 1;
        break;
      case 1: // when reaching first edge, stop and turn.
        if (medge.width > 0.15)
        {
          //pose.resetPose();
          mixer.setVelocity(0.0);
          mixer.setDesiredHeading(3.14);
          usleep(1000000); 
          mixer.setVelocity(-0.1);

          toLog("case 1: edge found - stopping and turning");
          state = 2;
          pose.dist = 0;
        }
        break;
      case 2: 
        if (pose.dist <= -0.1)
        {
          pose.dist = 0;
          pose.resetPose();
          state = 5;
        }
        break;
      case 5: // wait for Regbot, then go forward
        if (dist.dist[0] < 0.25)
        { // something is close, assume it is the Regbot
          // start driving
          //pose.resetPose();
          toLog("case 5: Tania passed - entering outer circle");
          mixer.setVelocity(0.20);
          state = 55;
        }
        else if (t.getTimePassed() > 30)
        {
          toLog("Gave up waiting for Regbot");
          lost = true;
        }
        break;
      case 55:
        if (medge.width > 0.15)
        {
          mixer.setVelocity(0.0);
          usleep(500000);
          mixer.setDesiredHeading(3.14);
          usleep(500000);
          state = 6;
        }
      case 6:
        if (dist.dist[0] <= 0.25 && pose.dist < 2)
        {
          mixer.setVelocity(0.0);
          toLog("case 6: something is infront - stopping");
          usleep(1000000);
        } 
        else if (pose.dist < 2)
        {
          mixer.setVelocity(0.25);
          toLog("case 6: proceeding");
        }
        else
        {
          toLog("case 6: circle complete");
          state = 7;
          //pose.resetPose();
          pose.dist = 0;
          break;
        }
        break;
      
      case 7: // TURN 90 DEGREE TO THE LEFT
        mixer.setDesiredHeading(3.14); //TURN 90 DEGREES IN 3 SEC.
        mixer.setVelocity(0.0);
        toLog("case 7: turning 90 deg to the left");
        state = 8;
        break;
      case 8:
        if (pose.turned >= 3.14)
        {
          //pose.resetPose();
          pose.turned = 0;
          pose.dist = 0;
          state = 9;
        }
        break;
      case 9: // MOVE BACKWARDS ONTO PLATFORM
        mixer.setVelocity(-0.2);
        state = 10;
        toLog("case 9: driving backwards");
        break;
      case 10:
        if (pose.dist < -0.2) //IF DISTANCE DRIVEN = ON PLATFORM
        {
          //pose.resetPose();
          mixer.setVelocity(0);
          //pose.resetPose();
          pose.dist = 0;
          state = 11;
          toLog("case 10: stopping - on platform");
        }
        else if (t.getTimePassed() > 10)
        {
          toLog("too long time");
          lost = true;
        }
        break;
      case 11:
        //pose.resetPose();
        mixer.setDesiredHeading(3.14);
        state = 12;
        toLog("case 11: turning 90 degrees to the left");
        break;
      case 12:
        if (pose.turned >= 3.14)
        {
          //pose.resetPose();
          pose.turned = 0;
          state = 13;
        }
        break;
      case 13:
        //pose.resetPose();
        mixer.setVelocity(-0.3);
        mixer.setTurnrate(0.628);
        state = 14;
        toLog("case 13: circling");
        break;
      case 14:
        if (pose.turned > 6.28)
        {
        //pose.resetPose();
        mixer.setTurnrate(0.0); //TURN 180 DEGREES IN 5 SEC.
        mixer.setVelocity(0.0);
        state = 15;
        toLog("case 14: circle complete");
        //pose.resetPose();
        pose.dist = 0;
        pose.turned = 0;
        }
        break;
      case 15:
        mixer.setDesiredHeading(-3.14);
        state = 16;
        toLog("case 15: turning 90 degrees to the right");
        break;
      case 16:
        if (pose.turned <= -3.14)
        {
          //pose.resetPose();
          pose.turned = 0;
          pose.dist = 0;
          state = 17;
        }
        break;
      case 17:
        if (dist.dist[0] < 0.25)
        { // something is close, assume it is the Regbot
          // start driving
          //pose.resetPose();
          mixer.setVelocity(0.25);
          mixer.setTurnrate(0);
          state = 18;
          toLog("case 17: Tania passed - driving forward");
          //pose.resetPose();
        }
        break;
      case 18:
        if (pose.dist > 0.2)
        {
          //pose.resetPose();
          mixer.setVelocity(0.0);
          mixer.setDesiredHeading(3.14);
          state = 19;
          toLog("case 18: exitted circle - turning 90 degrees left");
          lost = true;          
        }
        break;
      default:
        lost = true;
        break;
    }
    if (state != oldstate)
    { // C-type string print
      snprintf(s, MSL, "State change from %d to %d", oldstate, state);
      toLog(s);
      oldstate = state;
      t.now();
    }
    // wait a bit to offload CPU (4000 = 4ms)
    usleep(4000);
  }
  if (lost)
  { // there may be better options, but for now - stop
    toLog("Plan98 got lost - stopping");
    mixer.setVelocity(0);
    mixer.setTurnrate(0);
  }
  else
    toLog("Plan98 finished");
}


void BPlan98::terminate()
{ //
  if (logfile != nullptr)
    fclose(logfile);
  logfile = nullptr;
}

void BPlan98::toLog(const char* message)
{
  UTime t("now");
  if (logfile != nullptr)
  {
    fprintf(logfile, "%lu.%04ld %d %% %s\n", t.getSec(), t.getMicrosec()/100,
            oldstate,
            message);
  }
  if (toConsole)
  {
    printf("%lu.%04ld %d %% %s\n", t.getSec(), t.getMicrosec()/100,
           oldstate,
           message);
  }
}
