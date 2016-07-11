package com.litierses.Paginas;                                      //Package

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import com.example.android.xyztouristattractions.R;
import java.io.Serializable;

import com.litierses.Controladores.DietaManager;
import com.litierses.entities.Dieta;                               //Parametro del Page (tipo)

import android.widget.Button;                                        //tipo de componente grafico
import android.widget.EditText;                                     //tipo de componente grafico

public class EditDieta_Fragment extends Fragment {                   //nombre del Page + _fragment

    private static final String EXTRA_OBJECT = "EditDieta_object";                           // nombre Page
    private Dieta dieta;                                               //Parametro del Page (tipo)
    EditText text0;                                                      //componentes visuales EditText
    EditText text1;
    EditText text2;
    EditText text3;
    EditText text4;
    EditText text5;

    public static EditDieta_Fragment createInstance(Dieta dieta) {     //nombre del Page + _fragment //Parametro del Page (tipo+nombre)
        EditDieta_Fragment detailFragment = new EditDieta_Fragment();   //nombre del Page + _fragment
        Bundle bundle = new Bundle();
        bundle.putSerializable(EXTRA_OBJECT, (Serializable) dieta);     //Parametro del Page (nombre)
        detailFragment.setArguments(bundle);
        return detailFragment;
    }

    public EditDieta_Fragment() {}                       //nombre del Page + _fragment
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        setHasOptionsMenu(true);
        View view = inflater.inflate(R.layout.editdieta_fragment, container, false);       //nombre del Page + _fragment (minuscula)
        dieta = (Dieta) getArguments().getSerializable(EXTRA_OBJECT);                  //Parametro del Page (tipo+nombre)

        if (dieta == null) { getActivity().finish();       return null;     }
                                                                                        //componentes visuales EditText
        text0 = (EditText) view.findViewById(R.id.editTexto0);
        text0.setText(dieta.getNombre()+"");
        text1 = (EditText) view.findViewById(R.id.editTexto1);
        text1.setText(dieta.getDesayuno()+"");
        text2 = (EditText) view.findViewById(R.id.editTexto2);
        text2.setText(dieta.getAlmuerzo()+"");
        text3 = (EditText) view.findViewById(R.id.editTexto3);
        text3.setText(dieta.getCena()+"");
        text4 = (EditText) view.findViewById(R.id.editTexto4);
        text4.setText(dieta.getMerienda()+"");
        text5 = (EditText) view.findViewById(R.id.editTexto5);
        text5.setText(dieta.getId() +"");

        Button Save = (Button)view.findViewById(R.id.EditDieta_Save);                 //componentevisal - Button
        Save.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //text0 = (EditText) v.findViewById(R.id.editTexto0);
                dieta.setNombre(text0.getText()+"");       //componentes visuales EditText
                dieta.setDesayuno(text1.getText()+"");
                dieta.setAlmuerzo(text2.getText()+"");
                dieta.setCena(text3.getText()+"");
                dieta.setMerienda( text4.getText()+"");
                dieta.setId( Long.parseLong(text5.getText()+""));

                DietaManager.saveDieta(getActivity(), dieta);                     //controlador.metodo
            }
        });

        Button Cancel = (Button)view.findViewById(R.id.EditDieta_Cancel);                 //componentevisal - Button
        Cancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                DietaManager.listAll(getActivity());                     //controlador.metodo
            }
        });
        return view;
    }
}
