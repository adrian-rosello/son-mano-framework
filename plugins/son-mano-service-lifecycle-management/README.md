# SONATA's service lifecycle manager plugin

## Requires
* Docker
* Python 3.4
* pika

## Implementation
* The main implementation can be found in: `son_mano_slm/slm.py`

## How to run it

* (follow the general README.md of this repository to setup and test your environment)
* To run the SLM locally, you need:
 * a running RabbitMQ broker
 * a running plugin manager connected to the broker
 
 
* Run a local broker (in a Docker container): 
 * (do in `son-mano-framework/`)
 * `docker build -t broker -f son-mano-broker/Dockerfile .`
 * `docker run -d -p 5672:5672 --name broker broker`
 
 
* Run the plugin manager (in a Docker container):
 * (do in `son-mano-framework/`)
 * `docker build -t pluginmanager -f son-mano-pluginmanager/Dockerfile .`
 * `docker run -it --link broker:broker --name pluginmanager pluginmanager`


* Run the SLM (directly in your terminal not in a Docker container):
 * `python plugins/son-mano-service-lifecycle-management/son_mano_slm/slm.py`


* Or: run the SLM (in a Docker container):
 * (do in `son-mano-framework/`)
 * `docker build -t slm -f plugins/son-mano-service-lifecycle-management/Dockerfile .`
 * `docker run -it --link broker:broker --name slm slm`
 
 
## Output
The output of the SLm should look like this:

```
INFO:son-mano-base:plugin:Starting MANO Plugin: 'son-plugin.ServiceLifecycleManager' ...
INFO:son-mano-base:messaging:Broker configuration found: '/etc/son-mano/broker.config'
INFO:son-mano-base:messaging:Connecting to RabbitMQ on 'amqp://guest:guest@broker:5672/%2F'...
INFO:son-mano-base:messaging:Creating a new channel...
INFO:son-mano-base:messaging:Declaring exchange 'son-kernel'...
INFO:son-mano-base:plugin:Plugin registered with UUID: '37afe090-cf56-484a-8242-7808f83f4b52'
INFO:plugin:slm:Lifecycle start event
```

It shows how the SLM connects to the broker, registers itself to the plugin manager and receives the lifecycle start event.
