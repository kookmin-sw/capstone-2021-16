package com.example.capstone.UI.Calendar;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import com.example.capstone.R;

public class CalendarFragment  extends Fragment {
    private View v;
    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState){
        v = inflater.inflate(R.layout.fragment_calendar,container,false);


         /*
        일반 Activity와 다른 점은 view 를 리턴하는 것이 다르기 때문에
        Fragment에서는 layout에 원하는 오브젝트 ( 버튼, 텍스트 )를 선택하려면
        v.findViewById(R.id."id 값").setOnClickListener(onClickListener); 이런식으로 앞에 v. 만 붙여주면 된다.
         그리고 자신을 선택할때에는 AddPromiseActicity.this 이런식으로 하는게 아니고
         getActivity()를 대신한다.
        */

        return v;
    }
}
