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


#include "bplan111.h"

// create class object
BPlan111 plan111;


void BPlan111::setup()
{ // ensure there is default values in ini-file
  if (not ini["plan111"].has("log"))
  { // no data yet, so generate some default values
    ini["plan111"]["log"] = "true";
    ini["plan111"]["run"] = "false";
    ini["plan111"]["print"] = "true";
  }
  // get values from ini-file
  toConsole = ini["plan111"]["print"] == "true";
  //
  if (ini["plan111"]["log"] == "true")
  { // open logfile
    std::string fn = service.logPath + "log_plan111.txt";
    logfile = fopen(fn.c_str(), "w");
    fprintf(logfile, "%% Mission plan111 logfile\n");
    fprintf(logfile, "%% 1 \tTime (sec)\n");
    fprintf(logfile, "%% 2 \tMission state\n");
    fprintf(logfile, "%% 3 \t%% Mission status (mostly for debug)\n");
  }
  setupDone = true;
}

BPlan111::~BPlan111()
{
  terminate();
}


void BPlan111::run()
{
  if (not setupDone)
    setup();
  if (ini["plan111"]["run"] == "false")
    return;
  //
  UTime t("now");
  bool finished = false;
  bool lost = false;
  state = 10;
  oldstate = state;
  //
  toLog("plan111 started");
  //
  while (not finished and not lost and not service.stop)
  {
    switch (state)
    { // make a shift in heading-mission
      case 10:
        pose.resetPose();
        toLog("now work backward at 0.1m/s");
        mixer.setVelocity(0.6*(-1));
        mixer.setTurnrate(0);
        state = 11;
        break;
      case 11:
        pose.resetPose();
        toLog("distance reached");
        if (pose.dist >= 1.0){
          finished = true;
        }
        state = 12;
        break;
      case 12:
        pose.resetPose();
        toLog("forward at 0.1m/s");
        mixer.setVelocity(0.1);
        state = 13;
        break;
      case 13: // wait for distance
        if (pose.dist >= 2.0)
        { // done, and then
          finished = true;
        }
        else if (t.getTimePassed() > 30)
          lost = true;
        break;
      default:
        toLog("Unknown state");
        lost = true;
        break;
    }
    if (state != oldstate)
    {
      oldstate = state;
      toLog("state start");
      // reset time in new state
      t.now();
    }
    // wait a bit to offload CPU
    usleep(2000);
  }
  if (lost)
  { // there may be better options, but for now - stop
    toLog("plan111 got lost");
    mixer.setVelocity(0);
    mixer.setTurnrate(0);
  }
  else
    toLog("plan111 finished");
}


void BPlan111::terminate()
{ //
  if (logfile != nullptr)
    fclose(logfile);
  logfile = nullptr;
}

void BPlan111::toLog(const char* message)
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

