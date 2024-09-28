# quantum5

# envirorment

```shell
conda activate rl
python -m pip install godot-rl
python ..\stable_baselines3_example.py
pip install godot-rl[sb3]


while (1) {nvidia-smi; sleep 5}
```

# BallChase

```shell
cd D:\git\godot_exe
# descarregar joc
gdrl.env_from_hub -r edbeeching/godot_rl_BallChase
# entrenar
gdrl --env=rl --env_path=examples/godot_rl_BallChase/bin/BallChase.x86_64 --experiment_name=Experiment_01 --viz --speedup 8 --n_parallel 4
gdrl --env=rl --env_path=examples/godot_rl_BallChase/bin/BallChase.x86_64 --experiment_name=Experiment_01 --viz --speedup 8 --n_parallel 1

gdrl --env=rl --env_path=examples/godot_rl_BallChase/bin/BallChase.x86_64 --experiment_name=Experiment_01 --viz --speedup 8 --n_parallel 1 --timesteps=10_000 --onnx_export_path=model.onnx --save_model_path=model.zip


gdrl --env=rl --env_path=examples/godot_rl_BallChase/bin/BallChase.x86_64 --experiment_name=Experiment_01 --viz --speedup 8 --n_parallel 1 --timesteps=10_000 --save_checkpoint_frequency=1_000 --onnx_export_path=model.onnx --save_model_path=model.zip --experiment_dir="exp1"


python stable_baselines3_example.py --env=rl --experiment_name=Experiment_01 --timesteps=30_000 --save_checkpoint_frequency=10_000 --onnx_export_path=model.onnx   --save_model_path=model.zip 

````

- entrenament per GPU
- que guardi quan esta en mode no interactiu
- gdrl -h

usage: gdrl [-h] [--trainer {sb3,sf,rllib}] [--env_path ENV_PATH] [--config_file CONFIG_FILE] [--restore RESTORE] [--eval] [--speedup SPEEDUP] [--export] [--num_gpus NUM_GPUS] [--experiment_dir EXPERIMENT_DIR]
			[--experiment_name EXPERIMENT_NAME] [--viz] [--seed SEED]

options:
  -h, --help            show this help message and exit
  --trainer {sb3,sf,rllib}
						framework to use (rllib, sf, sb3)
  --env_path ENV_PATH   Godot binary to use
  --config_file CONFIG_FILE
						The yaml config file [only for rllib]
  --restore RESTORE     the location of a checkpoint to restore from
  --eval                whether to eval the model
  --speedup SPEEDUP     whether to speed up the physics in the env
  --export              wheter to export the model
  --num_gpus NUM_GPUS   Number of GPUs to use [only for rllib]
  --experiment_dir EXPERIMENT_DIR
						The name of the the experiment directory, in which the tensorboard logs are getting stored
  --experiment_name EXPERIMENT_NAME
						The name of the the experiment, which will be displayed in tensborboard
  --viz                 Whether to visualize one process
  --seed SEED           seed of the experiment

Monitor

```shell
tensorboard --logdir=logs\sb3
```

obrim url: http://localhost:6006/


# update

```shell
python -m pip install godot-rl --upgrade   # 0.8.1

```


```shell
python ..\stable_baselines3_example.py

while (1) {nvidia-smi; sleep 5}
```

- trebllar rewards
- trebllar el reset del joc eviatar reaload i fer reset

https://www.youtube.com/watch?v=f8arMv_rtUU



# RLLIB (No funciona)

```shell
conda create -n gdrl python=3.11.9 -y
conda activate gdrl 
python -m pip install godot-rl
pip uninstall -y stable-baselines3 gymnasium
pip install ray[rllib]

pip install https://github.com/edbeeching/godot_rl_agents/archive/refs/heads/main.zip 

pip uninstall -y stable-baselines3 gymnasium
pip install ray[rllib]

pip install PettingZoo

gdrl.env_from_hub -r edbeeching/godot_rl_<ENV_NAME>


```

download :
`https://github.com/edbeeching/godot_rl_agents/tree/main/examples`

- rllib_config.yaml
- rllib_example.py

save it in:

`D:\git\godot_rl_agents_examples`

ppo_test.yaml


Modify `D:\git\godot_rl_agents_examples\rllib_config.yaml`

```yaml
env_is_multiagent: true
num_gpus: 1
env: gdrl

```

```shell
cd D:\git\godot_rl_agents_examples
python rllib_example.py
```
gdrl --trainer=rllib --env=gdrl  --headless --export-debug "Windows Desktop" --path examples/MultiAgentSimple/bin/MultiAgentSimple.exe
examples/godot_rl_MultiAgentSimple/bin/MultiAgentSimple.exe

examples\MultiAgentSimple\bin

```shell

d:
cd  D:\git\godot_rl_agents_examples
gdrl --trainer=rllib --env=gdrl --env_path=examples/godot_rl_MultiAgentSimple/bin/MultiAgentSimple.x86_64 --speedup=8 --experiment_name=Experiment_01 --viz

while (1) {nvidia-smi; sleep 5}
```
	conda remove --name godo-rl --all
	edbeeching/godot_rl_MultiAgentSimple
