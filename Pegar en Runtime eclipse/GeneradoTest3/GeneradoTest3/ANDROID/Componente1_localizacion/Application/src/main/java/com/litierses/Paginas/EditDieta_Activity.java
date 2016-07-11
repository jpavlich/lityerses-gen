package com.litierses.Paginas;                                          //Package
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import java.io.Serializable;

import com.example.android.xyztouristattractions.R;                     //nombreproyecto.R
import com.litierses.entities.Dieta;                                   //Parametro del Page (tipo)

public class EditDieta_Activity extends AppCompatActivity {             //nombre del Page + _activity

    private static final String EXTRA_OBJECT = "EditDieta_object";                           // nombre Page

    public static void launch(Activity activity, Dieta dieta) {           //Parametro del Page (nombre + tipo)
        Intent intent = getLaunchIntent(activity, dieta);                 //Parametro del Page (nombre + tipo)
        activity.startActivity(intent);
    }

    public static Intent getLaunchIntent(Context context, Dieta dieta) {    //Parametro del Page (nombre + tipo)
        Intent intent = new Intent(context, EditDieta_Activity.class);      //nombre del Page + _activity
        intent.putExtra(EXTRA_OBJECT, (Serializable) dieta );              //Parametro del Page (nombre )
        return intent;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.editdieta_activity);                                 //nombre del Page + _activity (minuscula)
        Dieta dieta = (Dieta) getIntent().getSerializableExtra(EXTRA_OBJECT);       //Parametro del Page (nombre + tipo)
        if (savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction()
                    .add(R.id.container, EditDieta_Fragment.createInstance(dieta))    //nombre del Page + _Fragment //Parametro del Page (nombre )
                    .commit();
        }
    }
}
