%% Assignment 6 test bed
%rosinit

[client,goalMsg]=rosactionclient('/move_base')
        waitForServer(client);
        client.IsServerConnected
%I am running this with the Turtlebot running the AMCL navigation terminals.
set_initialpose(0,0,0)

% this is where the goal information will be put in
Xpos=[        1.6481
    1.8503
    4.9401
    3.9791
    5.2204
    3.9991
    0];
Ypos=[   -2.0476
   -0.8910
   -2.0832
   -5.0774
    1.3316
   -0.5884
   0];
Ya=[    0.8412
    0.9973
    0.8589
    0.9998
   -0.0779
   -0.0087
    0];

for i=1:length(Xpos)
    [client,goalMsg]=rosactionclient('/move_base')
        waitForServer(client);
        client.IsServerConnected
    X=Xpos(i)
    Y=Ypos(i)
    Yaw=Ya(i)
    GA(X,Y,Yaw,client,goalMsg)

end

rosshutdown()



