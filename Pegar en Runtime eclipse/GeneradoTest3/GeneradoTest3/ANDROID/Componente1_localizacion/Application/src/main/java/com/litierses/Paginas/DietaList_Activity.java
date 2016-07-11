package com.litierses.Paginas;                                          //Package
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;

import java.io.Serializable;


import com.example.android.xyztouristattractions.R;                     //nombreproyecto.R
import com.litierses.Controladores.DietaManager;
import com.litierses.entities.Dieta;                                   //Parametro del Page (tipo)   Sin collection
//Para colections
import java.util.ArrayList;


public class DietaList_Activity extends AppCompatActivity {             //nombre del Page + _activity



    private static final String EXTRA_OBJECT = "DietaList_object";                           // nombre Page

    public static void launch(Activity activity, ArrayList<Dieta> dietas) {           //Parametro del Page (nombre + tipo)
        Intent intent = getLaunchIntent(activity, dietas);                 //Parametro del Page (nombre + tipo)
        activity.startActivity(intent);
    }

    public static Intent getLaunchIntent(Context context, ArrayList<Dieta>  dietas) {    //Parametro del Page (nombre + tipo)
        Intent intent = new Intent(context, DietaList_Activity.class);      //nombre del Page + _activity
        intent.putExtra(EXTRA_OBJECT, (Serializable) dietas);              //Parametro del Page (nombre )
        return intent;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.dietalist_activity);                                 //nombre del Page + _activity (minuscula)
        ArrayList<Dieta> dietas = (ArrayList<Dieta>) getIntent().getSerializableExtra(EXTRA_OBJECT);       //Parametro del Page (nombre + tipo)

        //SI ES LA ACTIVIDAD INICIAL
        if (dietas == null) {    DietaManager.listAll(this);    }


        if (savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction()
                    .add(R.id.container, DietaList_Fragment.createInstance(dietas))    //nombre del Page + _Fragment //Parametro del Page (nombre )
                    .commit();
        }
    }


    /********************* Menu de la actividad inicial ******************************************************************/
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        switch (item.getItemId()) {
            case R.id.test_notification:
                //UtilityService.triggerWearTest(this, false);
                //showDebugDialog(R.string.action_test_notification,
                  //      R.string.action_test_notification_dialog);
                return true;
            case R.id.test_microapp:
                //U/tilityService.triggerWearTest(this, true);
                //showDebugDialog(R.string.action_test_microapp,
                 //       R.string.action_test_microapp_dialog);
                return true;
            case R.id.test_toggle_geofence:
                //boolean geofenceEnabled = Utils.getGeofenceEnabled(this);
                //Utils.storeGeofenceEnabled(this, !geofenceEnabled);
                Toast.makeText(this,
                        "Debug: Geofencing trigger disabled" , Toast.LENGTH_SHORT).show();
                return true;
        }
        return super.onOptionsItemSelected(item);
    }
    /********************* Menu de la actividad inicial ******************************************************************/
}
