Execute runrun_XXXX which executes runrun with variations and stores in folder learning_curves
To run in local machine remove bsub from run_xxx files and start from python train.py ....

# New Changes  
  * TRAIN:  
      ```sh train_all_models.sh <scenario-name> <#agents> <#adversaries> <#optional_savedir_suffix>```  <br />

    above script will start training, and saves model in "models/<ENV_NAME>\_policies/".  
    **Will overwrite existing folder, so make sure to either provide a suffix to the name of default save-directory or change all "work_dir" in above script,  to save to a new location instead of overwriting existing models.**.  
    Folder with 01-non-linear-MODEL are models with u_estimation False,
      and  02-non-linear-MODEL are models with u_estimation True.  

  * TEST:  
      ```sh  test.sh <scenaio-name> <#agents> <#adversaries> <U1> <U2>```  <br />
        - U1: u_estimation for Exp-Var Model (1=False, 2=True)  
        - U2: u_estimation for CVAR Model (1=False, 2=True)  

      above script will run all 3 models in test phase, one by one,
      and renders the graphical view.  
      Assumes trained model to be in "models/<ENV_NAME>\_policies/".  
      **If want to load custom model, need to change "work_dir" inside the script.**  
