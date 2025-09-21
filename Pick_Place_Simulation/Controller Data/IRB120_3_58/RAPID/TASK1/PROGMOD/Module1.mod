MODULE Module1
    CONST num delayTime := 0.5;
    CONST num Xincrement := 30;
    CONST num Yincrement := 30;
    CONST num SafetyZ_Offset := 100;
    
    VAR num Xpos := 0;
    VAR num Ypos := 0;
    
    CONST bool change_W := true;
    CONST robtarget A1:=[[44.42,44.75,32.14],[0.00216917,-0.19647,0.980507,0.00132944],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget B1:=[[44.64,-44.99,32.03],[0.000112033,-0.158303,0.987391,-1.79559E-5],[-1,0,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
	

    !***********************************************************
    !
    ! Module:  Module1
    !
    ! Description:
    !   <Insert description here>
    !
    ! Author: moka0036
    !
    ! Version: 1.0
    !
    !***********************************************************
    
    
    !***********************************************************
    !
    ! Procedure main
    !
    !   This is the entry point of your program
    !
    !***********************************************************
    PROC main()
        WaitTime delayTime;
        PulseDO Dtach;

        FOR Y FROM 0 TO 2 DO
            FOR X FROM 0 TO 2 DO
                PicknPlace(change_W);
                Xpos := Xpos + Xincrement;
            ENDFOR

            Ypos := Ypos + Yincrement;
            Xpos := 0;
        ENDFOR

        Ypos := 0;
    ENDPROC
    
    PROC PicknPlace(bool Change_W)
        MoveJ Offs(A1, Xpos, Ypos, SafetyZ_Offset), v1000, z50, Servo\WObj:=pegA_wb;
        MoveL Offs(A1, Xpos, Ypos, 0), v1000, fine, Servo\WObj:=pegA_wb; !MOVEs prior and after a Set/Reset must terminate FINE, otherwise the gripper will actuate prematurily
        PulseDO Dtach;
        WaitTime delayTime;
        PulseDO Attach;
        WaitTime delayTime;
        MoveL Offs(A1, Xpos, Ypos, SafetyZ_Offset), v1000, fine, Servo\WObj:=pegA_wb;
    
        MoveJ Offs(B1, Xpos, -Ypos, SafetyZ_Offset), v1000, z50, Servo\WObj:=pegB_wb;
        MoveL Offs(B1, Xpos, -Ypos, 0), v1000, fine, Servo\WObj:=pegB_wb;
        PulseDO Dtach;
        WaitTime delayTime;
        MoveL Offs(B1, Xpos, -Ypos, SafetyZ_Offset), v1000, fine, Servo\WObj:=pegB_wb;
    
        MoveL Offs(B1, Xpos, -Ypos, 0), v1000, fine, Servo\WObj:=pegB_wb;
        PulseDO Attach;
        WaitTime delayTime;
        MoveL Offs(B1, Xpos, -Ypos, SafetyZ_Offset), v1000, fine, Servo\WObj:=pegB_wb;
    ENDPROC !this should always end with the peg in the gripper AT a Safety_Point
      
ENDMODULE