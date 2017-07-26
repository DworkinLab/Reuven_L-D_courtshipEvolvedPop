## Data of Evolved populations:

  Data collected from the evolved populations (predation selection) and courtship times under light and dark conditions

### Prediction: 
  
  A higher ratio of night-time to daytime courtship in the predation than in the control populations.
  
### Data layout:

  Day == Day of trial
  
  Phase == light or Dark; corresponds to Time (start time) of 8 am (dark, red light) or 11 am (light, room lighting)
  
  Vial == Different recoreded vial of the day
  
  Observer == two observers A and R
  
  C_dur == Courtship duration in the session time (15 minutes or 900 seconds)
  
  P_court == proportion of time courting in session time (C_dur/900)
  
  Time == Start time
  
  Session == Session of recording: block within the hour of recording (3 sessions of 15 minutes?) with 2 replicates of each population is recorded over 3 sessions
  
  Trt == Predation selection treatment
  
  Population == Replicate population
  
  
### Model Options from Reuven:

Option 1: dark / light activity as the dependent factor, GLMM with day
(random), population (random within trt); fixed: trt. A priori contrast: higher dark / light
activity in 2 predation trt than control.

Option 2: activity as the dependent factor, GLMM with day (random), population
(random within trt); fixed: trt, session, trt x session. 2 predictions: overall lower activity in
predation than control; sig. trt x session interaction owing to higher dark activity in
predation trts.
  