\l qZigbee.q

.qZigbee.server:`$"192.168.1.111:1883";
.qZigbee.baseTopic:"zigbee2mqtt";

.qZigbee.init[];

.qZigbee.reqDevices[];
.qZigbee.reqNetworkMap[];

displayData:{
 show .qZigbee.state[];
 show .qZigbee.state`;
 show .qZigbee.config[];
 show .qZigbee.config`;
 show .qZigbee.log[];
 show .qZigbee.log`;
 show .qZigbee.devices[];
 show .qZigbee.devices`;
 };

time:.z.P;
.z.ts:{if[.z.P>time+0D00:00:10;displayData[];system"t 0"]};
\t 1000

