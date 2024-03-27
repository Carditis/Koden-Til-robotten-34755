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
  state = 5;
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
      case 5: // wait for Regbot, then go forward
        if (dist.dist[0] < 0.25)
        { // something is close, assume it is the Regbot
          // start driving
          pose.resetPose();
          toLog("forward 0.1 m/sec");
          mixer.setVelocity(0.25);
          mixer.setTurnrate(0);
          state = 12;
        }
        else if (t.getTimePassed() > 10)
        {
          toLog("Gave up waiting for Regbot");
          lost = true;
        }
        break;
      case 12: // forward until distance, then look for edge
        if (pose.dist > 0.3)
        {
          toLog("case 12 done: Continue until edge is found");
          state = 91;
          pose.dist = 0;
        }
        break;
      
      case 91: // TURN 180 DEGREE
        toLog("starting case 91");
        mixer.setTurnrate(3.14/5); //TURN 180 DEGREES IN 5 SEC.
        mixer.setVelocity(0.0);
        state = 90;
        break;
      case 90:
        if (pose.turned >= 3.14)
        {
          toLog("case 91 done: turned 180 degrees");
          state = 92;
          mixer.setTurnrate(0.0); //TURN 180 DEGREES IN 5 SEC.
          mixer.setVelocity(0.0);
          pose.resetPose();
        }
        else if (t.getTimePassed() > 10)
        {
          toLog("too long time");
          lost = true;
        }
        break;
      case 92: // MOVE BACKWARDS ONTO PLATFORM
        mixer.setVelocity(-0.2);
        state = 99;
      case 99:
        if (pose.dist < -0.2) //IF DISTANCE DRIVEN = ON PLATFORM
        {
          mixer.setVelocity(0);
          //pose.resetPose();
          state = 100;
          toLog("case 101");
        }
        else if (t.getTimePassed() > 10)
        {
          toLog("too long time");
          lost = true;
        }
        break;
      case 100:

        mixer.setTurnrate(3.14/5);
        state = 101;
        break;
      case 101:
        if (pose.turned > 3.14/2)
        {
          mixer.setTurnrate(0);
          //pose.resetPose();
          state = 102;
          toLog("case 102");
        }
        break;
      case 102:
        mixer.setVelocity(0.3);
        mixer.setTurnrate(0.628);
        state = 103;
        toLog("case 103");
        break;
      case 103:
        if (pose.turned > 6.28)
        {
        mixer.setTurnrate(0.0); //TURN 180 DEGREES IN 5 SEC.
        mixer.setVelocity(0.0);
        pose.resetPose();
        toLog("turned 6.28");
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
