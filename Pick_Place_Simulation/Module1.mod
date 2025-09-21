MODULE Module1
    CONST num delayTime := 0.5;
    CONST num Xincrement := 30;
    CONST num Yincrement := 30;
    CONST num SafetyZ_Offset := 150;
    
    VAR num Xpos := 0;
    VAR num Ypos := 0;
    
    CONST bool change_W := true;
	
    CONST robtarget A1:=[[270.52,178.8,363.02],[0.000388343,-0.284801,0.958587,0.000119302],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget B1:=[[294.22,-136.33,363.02],[9.5371E-9,0.218406,0.975858,-2.07013E-9],[-1,0,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
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
        PulseDO Detach;

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
        PulseDO Detach;
        WaitTime delayTime;
        PulseDO Attach;
        WaitTime delayTime;
        MoveL Offs(A1, Xpos, Ypos, SafetyZ_Offset), v1000, fine, Servo\WObj:=pegA_wb;
    
        MoveJ Offs(B1, Xpos, Ypos, SafetyZ_Offset), v1000, z50, Servo\WObj:=pegB_wb;
        MoveL Offs(B1, Xpos, Ypos, 0), v1000, fine, Servo\WObj:=pegB_wb;
        PulseDO Detach;
        WaitTime delayTime;
        MoveL Offs(B1, Xpos, Ypos, SafetyZ_Offset), v1000, fine, Servo\WObj:=pegB_wb;
    
        MoveL Offs(B1, Xpos, Ypos, 0), v1000, fine, Servo\WObj:=pegB_wb;
        PulseDO Attach;
        WaitTime delayTime;
        MoveL Offs(B1, Xpos, Ypos, SafetyZ_Offset), v1000, fine, Servo\WObj:=pegB_wb;
    ENDPROC !this should always end with the peg in the gripper AT a Safety_Point
      
ENDMODULE