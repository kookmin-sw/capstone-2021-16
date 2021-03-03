package com.example.capstone;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import com.example.capstone.Model.User;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class SignupActivity extends AppCompatActivity {
    private FirebaseAuth mAuth = FirebaseAuth.getInstance();
    private DatabaseReference mDatabase = FirebaseDatabase.getInstance().getReference();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_signup);
        findViewById(R.id.signup_complete_btn).setOnClickListener(onClickListener);
    }

    View.OnClickListener onClickListener = new View.OnClickListener(){

        @Override
        public void onClick(View v) {
            switch (v.getId()){
                case R.id.signup_complete_btn:
                    signUp();
                    break;
            }
        }
    };

    private void signUp(){
      final String email = ((EditText)findViewById(R.id.signup_email)).getText().toString();
      String password = ((EditText)findViewById(R.id.signup_password)).getText().toString();
      String passwordCheck = ((EditText)findViewById(R.id.signup_password_check)).getText().toString();
      final String name = ((EditText)findViewById(R.id.signup_name)).getText().toString();
      if (email.length()>0 && password.length()>0 && passwordCheck.length()>0 && name.length()>0) //null 값 체크 ( 3/3 )
      {
          if(password.equals(passwordCheck)){ // Password 일치하는치 Check ( 3/3 )
              mAuth.createUserWithEmailAndPassword(email,password).addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
                  @Override
                  public void onComplete(@NonNull Task<AuthResult> task) {
                      if(task.isSuccessful()){ // 회원가입 성공시 User Model을 통한 데이터 저장 ( 3/3 )
                          Toast.makeText(SignupActivity.this, "회원가입이 성공했습니다.", Toast.LENGTH_SHORT).show();
                          FirebaseUser user = mAuth.getCurrentUser();
                          String uid = user.getUid();
                          createNewUser(uid,email,name);
                          Intent intent = new Intent(SignupActivity.this,LoginActivity.class);
                          startActivity(intent);
                          finish();
                      }
                      else{
                          Toast.makeText(SignupActivity.this, "회원가입이 실패했습니다.", Toast.LENGTH_SHORT).show();
                      }
                  }
              });
          }else {
              Toast.makeText(SignupActivity.this, "비밀번호가 일치하지 않습니다.", Toast.LENGTH_SHORT).show();
          }
      }else{
          Toast.makeText(SignupActivity.this, "이메일또는 비밀번호를 입력해주세요", Toast.LENGTH_SHORT).show();
      }
    };
    private void createNewUser(String uid, String email, String username){
        User user = new User(uid,email,username);
        mDatabase.child("users").child(uid).setValue(user);
    }


}