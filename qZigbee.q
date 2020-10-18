\l mqtt.q

.qZigbee.data:([] time:`timestamp$();topic:();msg:());

.qZigbee.genTopic:{.qZigbee.baseTopic,"/",x};

.qZigbee.selectTopic:{select from .qZigbee.data where topic like .qZigbee.genTopic x};

.qZigbee.unixToQ:{e+s*(`long$x)+`long$((e:2000.01.01D0)-1970.01.01D0) div s:0D00:00:00.001};

.qZigbee.init:{
 .mqtt.conn[.qZigbee.server;`src;()!()];
 .mqtt.msgrcvd:{`.qZigbee.data insert (.z.P;x;y)};
 .mqtt.sub[`$.qZigbee.baseTopic,"/#"];
 };

.qZigbee.selectTopic:{select from .qZigbee.data where topic like .qZigbee.genTopic x};

.qZigbee.state:{t:.qZigbee.selectTopic"bridge/state"; if[x~(::);:t];
 "online"~last t`msg
 };

.qZigbee.config:{t:.qZigbee.selectTopic"bridge/config"; if[x~(::);:t];
 .j.k last t`msg
 };

.qZigbee.log:{t:.qZigbee.selectTopic"bridge/log"; if[x~(::);:t];
  select time,logType:msg[;`type],message:msg[;`message] from update .j.k each msg from t
 };

.qZigbee.devices:{t:.qZigbee.selectTopic"bridge/config/devices"; if[x~(::);:t];
  update .qZigbee.unixToQ lastSeen from () uj/enlist each .j.k @[;`msg] last t
 };

.qZigbee.reqDevices:{.mqtt.pub[`$.qZigbee.genTopic"bridge/config/devices/get";""]};

.qZigbee.reqNetworkMap:{.mqtt.pub[`$.qZigbee.genTopic"bridge/networkmap";"raw"]};

