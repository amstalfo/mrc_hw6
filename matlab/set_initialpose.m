function set_initialpose(xPos, yPos, hdgDegrees)   
    % takes in three arguments: x and y in meters, heading in degrees.
    % output is a message to the amcl node.
    initialpose = rospublisher('/amcl_pose')
    msg = rosmessage(initialpose)


    msg.Header.FrameId = 'map';

    msg.Pose.Pose.Position.X = xPos;
    msg.Pose.Pose.Position.Y = yPos;
    msg.Pose.Pose.Position.Z = 0;
    
    hdgRad = hdgDegrees;%*pi/180;
    q = eul2quat([hdgRad, 0, 0]);

    msg.Pose.Pose.Orientation.X = q(2);
    msg.Pose.Pose.Orientation.Y = q(3);
    msg.Pose.Pose.Orientation.Z = q(4);
    msg.Pose.Pose.Orientation.W = q(1);


    % covariance given by the assignment:
    msg.Pose.Covariance = [0.25, 0.0, 0.0, 0.0, 0.0, 0.0,...
                   0.0, 0.25,0.0, 0.0, 0.0, 0.0,...
                   0.0, 0.0, 0.0, 0.0, 0.0, 0.0,...
                   0.0, 0.0, 0.0, 0.0, 0.0, 0.0,...
                   0.0, 0.0, 0.0, 0.0, 0.0, 0.0,... 
                   0.0, 0.0, 0.0, 0.0, 0.0, 0.06853891945200942];

    send(initialpose, msg)
end
