package com.example.capstone;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

public class LoginActivity extends AppCompatActivity {
    private FirebaseAuth mAuth= FirebaseAuth.getInstance();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        findViewById(R.id.login_btn).setOnClickListener(onClickListener);
        findViewById(R.id.login_signup_btn).setOnClickListener(onClickListener);
    }

    View.OnClickListener onClickListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            switch (v.getId()){
                case R.id.login_btn:
                    login();
                    break;
                case R.id.login_signup_btn:
                    Intent intent = new Intent(LoginActivity.this,SignupActivity.class);
                    startActivity(intent);
                    finish();
                    break;
            }
        }
    };

    private void login(){
        final String email = ((EditText)findViewById(R.id.login_email)).getText().toString();
        String password = ((EditText)findViewById(R.id.login_password)).getText().toString();
        if(email.length()>0&&password.length()>0) //null 값 체크
        {
            mAuth.signInWithEmailAndPassword(email, password)
                    .addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
                        @Override
                        public void onComplete(@NonNull Task<AuthResult> task) {
                            if (task.isSuccessful()) {
                                FirebaseUser user =mAuth.getCurrentUser();
                                Intent intent = new Intent(LoginActivity.this,MainActivity.class);
                                startActivity(intent);
                                finish();
                            } else {
                                //로그인 실패시
                                Toast.makeText(LoginActivity.this, "아이디와 비밀번호가 정확하지 않습니다.",
                                        Toast.LENGTH_SHORT).show();
                            }

                        }
                    });
        }else{
            Toast.makeText(LoginActivity.this, "이메일또는 비밀번호를 입력해주세요", Toast.LENGTH_SHORT).show();
        }


    }

}