/*
 * PROJET_IO.c
 *
 * Classroom License -- for classroom instructional use only.  Not for
 * government, commercial, academic research, or other organizational use.
 *
 * Code generation for model "PROJET_IO".
 *
 * Model version              : 1.4
 * Simulink Coder version : 9.3 (R2020a) 18-Nov-2019
 * C source code generated on : Fri Mar  7 09:37:57 2025
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "PROJET_IO.h"
#include "PROJET_IO_private.h"
#include "PROJET_IO_dt.h"

/* options for Simulink Desktop Real-Time board 0 */
static double SLDRTBoardOptions0[] = {
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
};

/* list of Simulink Desktop Real-Time timers */
const int SLDRTTimerCount = 1;
const double SLDRTTimers[2] = {
  0.05, 0.0,
};

/* list of Simulink Desktop Real-Time boards */
const int SLDRTBoardCount = 1;
SLDRTBOARD SLDRTBoards[1] = {
  { "National_Instruments/PCI-6024E", 4294967295U, 6, SLDRTBoardOptions0 },
};

/* Block signals (default storage) */
B_PROJET_IO_T PROJET_IO_B;

/* Block states (default storage) */
DW_PROJET_IO_T PROJET_IO_DW;

/* Real-time model */
RT_MODEL_PROJET_IO_T PROJET_IO_M_;
RT_MODEL_PROJET_IO_T *const PROJET_IO_M = &PROJET_IO_M_;

/* Model output function */
void PROJET_IO_output(void)
{
  /* Step: '<Root>/Step' */
  if (PROJET_IO_M->Timing.t[0] < PROJET_IO_P.Step_Time) {
    PROJET_IO_B.Step = PROJET_IO_P.Step_Y0;
  } else {
    PROJET_IO_B.Step = PROJET_IO_P.Step_YFinal;
  }

  /* End of Step: '<Root>/Step' */

  /* S-Function (sldrtao): '<Root>/Analog Output' */
  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) PROJET_IO_P.AnalogOutput_RangeMode;
      parm.rangeidx = PROJET_IO_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &PROJET_IO_P.AnalogOutput_Channels, ((real_T*)
        (&PROJET_IO_B.Step)), &parm);
    }
  }

  /* S-Function (sldrtai): '<Root>/Analog Input' */
  /* S-Function Block: <Root>/Analog Input */
  {
    ANALOGIOPARM parm;
    parm.mode = (RANGEMODE) PROJET_IO_P.AnalogInput_RangeMode;
    parm.rangeidx = PROJET_IO_P.AnalogInput_VoltRange;
    RTBIO_DriverIO(0, ANALOGINPUT, IOREAD, 1, &PROJET_IO_P.AnalogInput_Channels,
                   &PROJET_IO_B.AnalogInput, &parm);
  }
}

/* Model update function */
void PROJET_IO_update(void)
{
  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++PROJET_IO_M->Timing.clockTick0)) {
    ++PROJET_IO_M->Timing.clockTickH0;
  }

  PROJET_IO_M->Timing.t[0] = PROJET_IO_M->Timing.clockTick0 *
    PROJET_IO_M->Timing.stepSize0 + PROJET_IO_M->Timing.clockTickH0 *
    PROJET_IO_M->Timing.stepSize0 * 4294967296.0;

  {
    /* Update absolute timer for sample time: [0.05s, 0.0s] */
    /* The "clockTick1" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick1"
     * and "Timing.stepSize1". Size of "clockTick1" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick1 and the high bits
     * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++PROJET_IO_M->Timing.clockTick1)) {
      ++PROJET_IO_M->Timing.clockTickH1;
    }

    PROJET_IO_M->Timing.t[1] = PROJET_IO_M->Timing.clockTick1 *
      PROJET_IO_M->Timing.stepSize1 + PROJET_IO_M->Timing.clockTickH1 *
      PROJET_IO_M->Timing.stepSize1 * 4294967296.0;
  }
}

/* Model initialize function */
void PROJET_IO_initialize(void)
{
  /* Start for S-Function (sldrtao): '<Root>/Analog Output' */

  /* S-Function Block: <Root>/Analog Output */

  /* no initial value should be set */
}

/* Model terminate function */
void PROJET_IO_terminate(void)
{
  /* Terminate for S-Function (sldrtao): '<Root>/Analog Output' */

  /* S-Function Block: <Root>/Analog Output */

  /* no final value should be set */
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/
void MdlOutputs(int_T tid)
{
  PROJET_IO_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  PROJET_IO_update();
  UNUSED_PARAMETER(tid);
}

void MdlInitializeSizes(void)
{
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  PROJET_IO_initialize();
}

void MdlTerminate(void)
{
  PROJET_IO_terminate();
}

/* Registration function */
RT_MODEL_PROJET_IO_T *PROJET_IO(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)PROJET_IO_M, 0,
                sizeof(RT_MODEL_PROJET_IO_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&PROJET_IO_M->solverInfo,
                          &PROJET_IO_M->Timing.simTimeStep);
    rtsiSetTPtr(&PROJET_IO_M->solverInfo, &rtmGetTPtr(PROJET_IO_M));
    rtsiSetStepSizePtr(&PROJET_IO_M->solverInfo, &PROJET_IO_M->Timing.stepSize0);
    rtsiSetErrorStatusPtr(&PROJET_IO_M->solverInfo, (&rtmGetErrorStatus
      (PROJET_IO_M)));
    rtsiSetRTModelPtr(&PROJET_IO_M->solverInfo, PROJET_IO_M);
  }

  rtsiSetSimTimeStep(&PROJET_IO_M->solverInfo, MAJOR_TIME_STEP);
  rtsiSetSolverName(&PROJET_IO_M->solverInfo,"FixedStepDiscrete");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = PROJET_IO_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;
    PROJET_IO_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    PROJET_IO_M->Timing.sampleTimes = (&PROJET_IO_M->Timing.sampleTimesArray[0]);
    PROJET_IO_M->Timing.offsetTimes = (&PROJET_IO_M->Timing.offsetTimesArray[0]);

    /* task periods */
    PROJET_IO_M->Timing.sampleTimes[0] = (0.0);
    PROJET_IO_M->Timing.sampleTimes[1] = (0.05);

    /* task offsets */
    PROJET_IO_M->Timing.offsetTimes[0] = (0.0);
    PROJET_IO_M->Timing.offsetTimes[1] = (0.0);
  }

  rtmSetTPtr(PROJET_IO_M, &PROJET_IO_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = PROJET_IO_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    PROJET_IO_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(PROJET_IO_M, 10.0);
  PROJET_IO_M->Timing.stepSize0 = 0.05;
  PROJET_IO_M->Timing.stepSize1 = 0.05;

  /* External mode info */
  PROJET_IO_M->Sizes.checksums[0] = (2695518537U);
  PROJET_IO_M->Sizes.checksums[1] = (3913854998U);
  PROJET_IO_M->Sizes.checksums[2] = (1893786071U);
  PROJET_IO_M->Sizes.checksums[3] = (366773735U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[1];
    PROJET_IO_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(PROJET_IO_M->extModeInfo,
      &PROJET_IO_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(PROJET_IO_M->extModeInfo, PROJET_IO_M->Sizes.checksums);
    rteiSetTPtr(PROJET_IO_M->extModeInfo, rtmGetTPtr(PROJET_IO_M));
  }

  PROJET_IO_M->solverInfoPtr = (&PROJET_IO_M->solverInfo);
  PROJET_IO_M->Timing.stepSize = (0.05);
  rtsiSetFixedStepSize(&PROJET_IO_M->solverInfo, 0.05);
  rtsiSetSolverMode(&PROJET_IO_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  PROJET_IO_M->blockIO = ((void *) &PROJET_IO_B);
  (void) memset(((void *) &PROJET_IO_B), 0,
                sizeof(B_PROJET_IO_T));

  /* parameters */
  PROJET_IO_M->defaultParam = ((real_T *)&PROJET_IO_P);

  /* states (dwork) */
  PROJET_IO_M->dwork = ((void *) &PROJET_IO_DW);
  (void) memset((void *)&PROJET_IO_DW, 0,
                sizeof(DW_PROJET_IO_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    PROJET_IO_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 14;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  PROJET_IO_M->Sizes.numContStates = (0);/* Number of continuous states */
  PROJET_IO_M->Sizes.numY = (0);       /* Number of model outputs */
  PROJET_IO_M->Sizes.numU = (0);       /* Number of model inputs */
  PROJET_IO_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  PROJET_IO_M->Sizes.numSampTimes = (2);/* Number of sample times */
  PROJET_IO_M->Sizes.numBlocks = (4);  /* Number of blocks */
  PROJET_IO_M->Sizes.numBlockIO = (2); /* Number of block outputs */
  PROJET_IO_M->Sizes.numBlockPrms = (13);/* Sum of parameter "widths" */
  return PROJET_IO_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
