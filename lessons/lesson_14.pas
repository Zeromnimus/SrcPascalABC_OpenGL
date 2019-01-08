﻿{$reference Tao.FreeGlut.dll}
{$reference Tao.OpenGl.dll}

uses
   System, System.Collections.Generic, System.Linq, System.Text, 
   Tao.OpenGl, Tao.FreeGlut;

const
  Key_W = 119; 
  Key_S = 115;
  Key_A = 97;
  Key_D = 100;
  Key_ESC = 27;
 
const
  Width = 600;
  Height = 480;

var
  posX : single  := 0.0;
  posY : single  := 0.0;
  posZ : single  := 0.0;
  

//****************************************************// 
//*******      Процедура создания куба      **********//
//****************************************************// 
procedure DrawCube();
begin
  // front
  GL.glColor3f(1.0, 0.0, 0.0);
  GL.glBegin(GL.GL_QUADS);
    gl.glVertex3f( -2.0,  2.0,  2.0); // 1
    gl.glVertex3f( -2.0, -2.0,  2.0); // 2 
    gl.glVertex3f(  2.0, -2.0,  2.0); // 3
    gl.glVertex3f(  2.0,  2.0,  2.0); // 4
  GL.glEnd();
 
  // back
  GL.glColor3f(0.0, 1.0, 0.0);
  GL.glBegin(GL.GL_QUADS);
    gl.glVertex3f( -2.0,  2.0, -2.0); // 5
    gl.glVertex3f( -2.0, -2.0, -2.0); // 6
    gl.glVertex3f(  2.0, -2.0, -2.0); // 7
    gl.glVertex3f(  2.0,  2.0, -2.0); // 8
  GL.glEnd();
  
  // left
  GL.glColor3f(0.0, 0.0, 1.0);
  GL.glBegin(GL.GL_QUADS);
    gl.glVertex3f( -2.0,  2.0, -2.0); // 5
    gl.glVertex3f( -2.0, -2.0, -2.0); // 6
    gl.glVertex3f( -2.0, -2.0,  2.0); // 2 
    gl.glVertex3f( -2.0,  2.0,  2.0); // 1
  GL.glEnd();
  
  // right
  GL.glColor3f(1.0, 1.0, 0.0);
  GL.glBegin(GL.GL_QUADS);
    gl.glVertex3f(  2.0, -2.0, -2.0); // 7
    gl.glVertex3f(  2.0,  2.0, -2.0); // 8
    gl.glVertex3f(  2.0,  2.0,  2.0); // 4    
    gl.glVertex3f(  2.0, -2.0,  2.0); // 3
  GL.glEnd();
   
  // top
  GL.glColor3f(1.0, 0.0, 1.0);
  GL.glBegin(GL.GL_QUADS);
    gl.glVertex3f( -2.0,  2.0,  2.0); // 1
    gl.glVertex3f(  2.0,  2.0,  2.0); // 4    
    gl.glVertex3f(  2.0,  2.0, -2.0); // 8
    gl.glVertex3f( -2.0,  2.0, -2.0); // 5
  GL.glEnd();

  // down
  GL.glColor3f(0.5, 0.0, 0.5);
  GL.glBegin(GL.GL_QUADS);
    gl.glVertex3f(  2.0, -2.0,  2.0); // 3
    gl.glVertex3f( -2.0, -2.0,  2.0); // 2  
    gl.glVertex3f( -2.0, -2.0, -2.0); // 6
    gl.glVertex3f(  2.0, -2.0, -2.0); // 7
  GL.glEnd();
end;

procedure DrawHuman();
begin

    // тело 1-2
    GL.glPushMatrix(); 
     // 1
     GL.glPushMatrix();
       GL.glTranslatef(0.0, 0.0, 0.0);
       GL.glColor3f(0.9, 0.1, 0.6);
       GLUT.glutSolidCube(1.0);
     GL.glPopMatrix();
     // 2
     GL.glPushMatrix();
       GL.glTranslatef(0.0, -1.0, 0.0);
       GL.glColor3f(0.9, 0.1, 0.6);
       GLUT.glutSolidCube(1.0);
     GL.glPopMatrix();
     
     GL.glPopMatrix(); // 1-2 
    
    // пр. рука
    GL.glPushMatrix();
    GL.glColor3f(0.9, 0.6, 0.6);
    GL.glTranslatef(1.0, 0.0, 0.0);
    GLUT.glutSolidCube(1.0);
    GL.glPopMatrix();
    
    // лев. рука
    GL.glPushMatrix();
    GL.glColor3f(0.9, 0.6, 0.1);
    GL.glTranslatef(-1.0, 0.0, 0.0);
    GLUT.glutSolidCube(1.0);
    GL.glPopMatrix();
    
    // голова
    GL.glPushMatrix();
    GL.glColor3f(0.1, 0.6, 0.1);
    GL.glTranslatef(0.0, 1.0, 0.0);
    GLUT.glutSolidCube(1.0);
    GL.glPopMatrix();
    


end;
  
//****************************************************// 
//***  Инициализация ресурсов приложения и OpenGL  ***//
//****************************************************// 
procedure InitScene();
begin  
  Writeln( GL.glGetString(GL.GL_VERSION));
  GL.glClearColor(0.0, 0.0, 0.0, 0.0); 
  
  gl.glEnable(gl.GL_DEPTH_TEST);
  
end;

//****************************************************// 
//***   Процедура отрисовки                        ***//
//***   Данная процедура вызывается каждый кадр    ***//
//****************************************************// 
procedure RenderScene();
begin
 GL.glLoadIdentity();
 //GL.glTranslatef(0.0, -2.0, 0.0);
 
 Glu.gluLookAt( 0.0, 0.0, 10.0,
                0.0, 0.0, 0.0,
                0.0, 1.0, 0.0);

  GL.glClear(GL.GL_COLOR_BUFFER_BIT or GL.GL_DEPTH_BUFFER_BIT);

   
 GL.glPushMatrix(); 
  GL.glTranslatef(posX, posY, posZ);
  DrawHuman();
 GL.glPopMatrix();
  
  
  Glut.glutSwapBuffers;
end;

//****************************************************// 
//*** Процедура таймер.                            ***//
//*** Вызывается каждые 40 мсек для отрисовка кадра **//
//****************************************************// 
procedure Timer(val: integer);
begin
  Glut.glutPostRedisplay();
  Glut.glutTimerFunc(40, Timer, 0);
end;

//****************************************************// 
//***  Процедура перенастройки                     ***//
//***  Проц. вызыв. при изменении размера экрана   ***//
//****************************************************//
procedure Reshape(w, h: integer);
begin

 gl.glViewport(0,0, w, h);
 gl.glMatrixMode(gl.GL_PROJECTION);
 gl.glLoadIdentity();
 
 glu.gluPerspective(45, w/h, 0.1, 10000.0);

 
 gl.glMatrixMode(gl.GL_MODELVIEW);
 gl.glLoadIdentity();

end;

procedure pressKey ( key, x, y : integer );
begin

  if ( key = glut.GLUT_KEY_F2 ) then glut.glutLeaveMainLoop();
  
end;


procedure pressKey2 ( key : byte; x, y : integer );
var
 ch : char;
begin
{
 case key of
  Key_W  : posY := posY + 1.0;   
  Key_S  : posY := posY - 1.0;  
  Key_A  : posX := posX - 1.0;   
  Key_D  : posX := posX + 1.0;  
  Key_ESC : glut.glutLeaveMainLoop(); 
  else writeln( key );
 end;
}

 ch := CHR( key ); 
 case ch of
  'w' : posY := posY + 1.0;   
  's' : posY := posY - 1.0;  
  'a' : posX := posX - 1.0;   
  'd' : posX := posX + 1.0;  
 // Key_ESC : glut.glutLeaveMainLoop(); 
  else writeln( key );
 end;
 
 
  
end;



begin
  Glut.glutInit(); 
  Glut.glutInitWindowSize(Width, Height);
  Glut.glutInitWindowPosition(300, 200); 
  Glut.glutInitDisplayMode(GLUT.GLUT_RGBA or Glut.GLUT_DOUBLE or GLUT.GLUT_DEPTH);
  Glut.glutCreateWindow('Tao Example');  
  Glut.glutDisplayFunc(RenderScene);
  Glut.glutReshapeFunc(Reshape);
  Glut.glutTimerFunc(40, Timer, 0);
  
  glut.glutSpecialFunc  ( pressKey  );
  glut.glutKeyboardFunc ( pressKey2 );
  
  InitScene();
  Glut.glutMainLoop();
end.
