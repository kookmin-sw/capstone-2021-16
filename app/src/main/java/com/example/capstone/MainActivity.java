package com.example.capstone;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentTransaction;

import android.os.Bundle;
import android.view.View;

import com.example.capstone.UI.AddPromise.AddPromiseFragment;
import com.example.capstone.UI.Alarm.AlarmFragment;
import com.example.capstone.UI.Calendar.CalendarFragment;
import com.example.capstone.UI.Home.HomeFragment;
import com.example.capstone.UI.Profile.ProfileFragment;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        // MainActivity는 분기점만 나누어지게 하는  수단

        //프래그먼트 이동 버튼 모음
        findViewById(R.id.nav_home_btn).setOnClickListener(onClickListener);
        findViewById(R.id.nav_plus_btn).setOnClickListener(onClickListener);
        findViewById(R.id.nav_alarm_btn).setOnClickListener(onClickListener);
        findViewById(R.id.nav_calendar_btn).setOnClickListener(onClickListener);
        findViewById(R.id.nav_profile_btn).setOnClickListener(onClickListener);
        setDefaultFragment(); // 첫번째 띄워지는 화면 Default를 Home로 하기위한 메소드
    }

    View.OnClickListener onClickListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            //프래그먼트 객체 생성후  버튼 클릭시 id 값에 따라 각각 프래그먼트로 이동하는 로직
            //activity_main 에 있는 id = frame 에 적용되는 화면들
            FragmentTransaction transaction = getSupportFragmentManager().beginTransaction();
            switch (v.getId()) {
                case R.id.nav_profile_btn:
                    ProfileFragment profileFragment = new ProfileFragment();
                    transaction.replace(R.id.frame, profileFragment);
                    transaction.addToBackStack(null);
                    transaction.commit();
                    break;
                case R.id.nav_home_btn:
                    HomeFragment homeFragment = new HomeFragment();
                    transaction.replace(R.id.frame, homeFragment);
                    transaction.addToBackStack(null);
                    transaction.commit();
                    break;
                case R.id.nav_plus_btn:
                    AddPromiseFragment addpromiseFragment = new AddPromiseFragment();
                    transaction.replace(R.id.frame, addpromiseFragment);
                    transaction.addToBackStack(null);
                    transaction.commit();
                    break;
                case R.id.nav_calendar_btn:
                    CalendarFragment calendarFragment = new CalendarFragment();
                    transaction.replace(R.id.frame, calendarFragment);
                    transaction.addToBackStack(null);
                    transaction.commit();
                    break;
                case R.id.nav_alarm_btn:
                    AlarmFragment alarmFragment = new AlarmFragment();
                    transaction.replace(R.id.frame, alarmFragment);
                    transaction.addToBackStack(null);
                    transaction.commit();
                    break;


            }
        }
    };

    public void setDefaultFragment(){
        // 첫번쩨 프래그먼트는 mycloset 로 하기 위한 작업 (현서 11/6일 )
        FragmentTransaction transaction = getSupportFragmentManager().beginTransaction();
        HomeFragment homeFragment = new HomeFragment();
        transaction.add(R.id.frame,homeFragment);
        transaction.commit();
    }
}