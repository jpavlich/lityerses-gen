package com.litierses.Paginas;                                      //Package

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import com.example.android.xyztouristattractions.R;
import java.io.Serializable;

import com.litierses.Controladores.DietaManager;         //Controlador
import com.litierses.entities.Dieta;                               //Parametro del Page (tipo)
import android.widget.Button;                                       //tipo de componente grafico
import android.widget.TextView;                                     //tipo de componente grafico

public class ViewDieta_Fragment extends Fragment {                   //nombre del Page + _fragment

    private static final String EXTRA_OBJECT = "ViewDieta_object";                           // nombre Page
    private Dieta mDieta;                                               //Parametro del Page (tipo)

    public static ViewDieta_Fragment createInstance(Dieta dieta) {     //nombre del Page + _fragment //Parametro del Page (tipo+nombre)
        ViewDieta_Fragment detailFragment = new ViewDieta_Fragment();   //nombre del Page + _fragment
        Bundle bundle = new Bundle();
        bundle.putSerializable(EXTRA_OBJECT, (Serializable) dieta);     //Parametro del Page (nombre)
        detailFragment.setArguments(bundle);
        return detailFragment;
    }

    public ViewDieta_Fragment() {}                       //nombre del Page + _fragment

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        setHasOptionsMenu(true);
        View view = inflater.inflate(R.layout.viewdieta_fragment, container, false);       //nombre del Page + _fragment (minuscula)
        mDieta = (Dieta) getArguments().getSerializable(EXTRA_OBJECT);                  //Parametro del Page (tipo+nombre)

        if (mDieta == null) { getActivity().finish();       return null;     }

        TextView text0 = (TextView) view.findViewById(R.id.viewTexto0);                 //Elementos graficos del page - TextView
        text0.setText(mDieta.getNombre()+"");
        TextView text1 = (TextView) view.findViewById(R.id.viewTexto1);
        text1.setText(mDieta.getDesayuno()+"");
        TextView text2 = (TextView) view.findViewById(R.id.viewTexto2);
        text2.setText(mDieta.getAlmuerzo()+"");
        TextView text3 = (TextView) view.findViewById(R.id.viewTexto3);
        text3.setText(mDieta.getCena()+"");
        TextView text4 = (TextView) view.findViewById(R.id.viewTexto4);
        text4.setText(mDieta.getMerienda()+"");
        TextView text5 = (TextView) view.findViewById(R.id.viewTexto5);
        text5.setText(mDieta.getId() +"");

        Button OK = (Button)view.findViewById(R.id.ViewDieta_OK);                 //componentevisal - Button
        OK.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                DietaManager.listAll(getActivity());                     //controlador.metodo
            }
        });

        return view;
    }
}
