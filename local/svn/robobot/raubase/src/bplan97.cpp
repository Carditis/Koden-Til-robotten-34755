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

#include "bplan97.h"

// create class object
BPlan97 plan97;


void BPlan97::setup()
{ // ensure there is default values in ini-file
  if (not ini["plan97"].has("log"))
  { // no data yet, so generate some default values
    ini["plan97"]["log"] = "true";
    ini["plan97"]["run"] = "false";
    ini["plan97"]["print"] = "true";
  }
  // get values from ini-file
  toConsole = ini["plan97"]["print"] == "true";
  //
  if (ini["plan97"]["log"] == "true")
  { // open logfile
    std::string fn = service.logPath + "log_plan97.txt";
    logfile = fopen(fn.c_str(), "w");
    fprintf(logfile, "%% Mission plan97 logfile\n");
    fprintf(logfile, "%% 1 \tTime (sec)\n");
    fprintf(logfile, "%% 2 \tMission state\n");
    fprintf(logfile, "%% 3 \t%% Mission status (mostly for debug)\n");
  }
  setupDone = true;
}

BPlan97::~BPlan97()
{
  terminate();
}

void BPlan97::run()
{
  if (not setupDone)
    setup();
  if (ini["plan97"]["run"] == "false")
    return;
  UTime t("now");
  bool finished = false;
  bool lost = false;
  state = 1;
  oldstate = state;
  const int MSL = 100;
  char s[MSL];
  //
  toLog("Plan97 started");
  //
  while (not finished and not lost and not service.stop)
  {
    switch (state)
    {

      case 1: // after x meters, then slow down for better line detection
        if (pose.dist > 5)
        {
          mixer.setVelocity(0.1);
          toLog("case 1: slowing down");
          state = 2;
        }
        break;
      case 2: // if sharp turn. stop.
        if (pose.turned > 3.14/3)
        {
          mixer.setVelocity(0.0);
          toLog("case 2: stopping");
          state = 3;
        }
        break;
      case 3: // backing off
        mixer.setVelocity(-0.1);
        toLog("case 3: backing of");
        state = 4;
        break;
      case 4: // stopping
        if (pose.dist > 0.1);
        {
          setVelocity(0.0);
          toLog("case 4: stopping");
          state = 5;

        }

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
    toLog("Plan97 got lost - stopping");
    mixer.setVelocity(0);
    mixer.setTurnrate(0);
  }
  else
    toLog("Plan97 finished");
}


void BPlan97::terminate()
{ //
  if (logfile != nullptr)
    fclose(logfile);
  logfile = nullptr;
}

void BPlan97::toLog(const char* message)
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
