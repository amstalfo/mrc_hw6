function []=GA(xpos, ypos, yaw, client,goalMsg)
    %rostopic list

    

    client.ActivationFcn=@(~)disp('Goal active');client.FeedbackFcn=@(~,msg)fprintf('Feedback: X=%.2f, Y=%.2f, yaw=%.2f, pitch=%.2f, roll=%.2f  \n',msg.BasePosition.Pose.Position.X,...
        msg.BasePosition.Pose.Position.Y,quat2eul([msg.BasePosition.Pose.Orientation.W,...
        msg.BasePosition.Pose.Orientation.X,msg.BasePosition.Pose.Orientation.Y, ...
        msg.BasePosition.Pose.Orientation.Z]));

    client.FeedbackFcn=@(~,msg)fprintf('Feedback: X=%.2f\n',msg.BasePosition.Pose.Position.X);
    client.ResultFcn=@(~,res)fprintf('Result received: State: <%s>, StatusText: <%s>\n',res.State,res.StatusText);

    goalMsg.TargetPose.Header.FrameId = 'map';
    goalMsg.TargetPose.Pose.Position.X = xpos;
    goalMsg.TargetPose.Pose.Position.Y = ypos;
    yawtgt = yaw;%/57.3;   % Setting the target heading
    q = eul2quat([yawtgt, 0,0]);
    goalMsg.TargetPose.Pose.Orientation.W=q(1);
    goalMsg.TargetPose.Pose.Orientation.X=q(2);
    goalMsg.TargetPose.Pose.Orientation.Y=q(3);
    goalMsg.TargetPose.Pose.Orientation.Z=q(4);

%     resultmsg = sendGoalAndWait(client,goalMsg);
    sendGoalAndWait(client,goalMsg);
%     fprintf('Action completed: State: <%s>, StatusText: <%s>\n',resultmsg.State,resultmsg.StatusText);

    cancelAllGoals(client)
    delete(client)
    clear goalMsg
end

