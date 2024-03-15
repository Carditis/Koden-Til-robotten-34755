

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


#include "bplan301.h"

// create class object
BPlan301 plan301;


void BPlan301::setup()
{ // ensure there is default values in ini-file
  if (not ini["plan301"].has("log"))
  { // no data yet, so generate some default values
    ini["plan301"]["log"] = "true";
    ini["plan301"]["run"] = "false";
    ini["plan301"]["print"] = "true";
  }
  // get values from ini-file
  toConsole = ini["plan301"]["print"] == "true";
  //
  if (ini["plan301"]["log"] == "true")
  { // open logfile
    std::string fn = service.logPath + "log_plan301.txt";
    logfile = fopen(fn.c_str(), "w");
    fprintf(logfile, "%% Mission plan301 logfile\n");
    fprintf(logfile, "%% 1 \tTime (sec)\n");
    fprintf(logfile, "%% 2 \tMission state\n");
    fprintf(logfile, "%% 3 \t%% Mission status (mostly for debug)\n");
  }
  setupDone = true;
}

BPlan301::~BPlan301()
{
  terminate();
}


void BPlan301::run()
{
  if (not setupDone)
    setup();
  if (ini["plan301"]["run"] == "false")
    return;
  //
  UTime t("now");
  bool finished = false;
  bool lost = false;
  state = 10;
  oldstate = state;
  //
  toLog("Plan301 started");
  //
  while (not finished and not lost and not service.stop)
  {
    switch (state)
    { // make a shift in heading-mission
      case 10:
        toLog("Reset pose");
        pose.resetPose();

        toLog("forward at 0.3m/s");
        mixer.setVelocity(0.3);
        state = 11;
        break;
      case 11: // wait for distance
        if (pose.dist >= 0.3)
        { // done, and then
          toLog("now turn at 0.5 rad/s and 0 m/s");
          // reset turned angle
          pose.turned = 0.0;
          mixer.setVelocity(0.0);
          mixer.setTurnrate(0.5);
          state = 21;
        }
        else if (t.getTimePassed() > 10)
          lost = true;
        break;
      case 21:
        if (pose.turned >= M_PI)
        {
          mixer.setDesiredHeading(M_PI);
          toLog("now go back");
          mixer.setVelocity(0.3);
          // reset driven distance
          pose.dist = 0;
          state = 31;
        }
        else if (t.getTimePassed() > 12)
          lost = true;
        break;
      case 31: // wait for distance
        if (pose.dist >= 0.3)
        { // the end
          mixer.setVelocity(0.0);
          finished = true;
        }
        else if (t.getTimePassed() > 10)
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
    toLog("Plan301 got lost");
    mixer.setVelocity(0);
    mixer.setTurnrate(0);
  }
  else
    toLog("Plan301 finished");
}


void BPlan301::terminate()
{ //
  if (logfile != nullptr)
    fclose(logfile);
  logfile = nullptr;
}

void BPlan301::toLog(const char* message)
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