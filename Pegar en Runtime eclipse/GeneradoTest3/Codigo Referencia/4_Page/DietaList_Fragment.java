package com.litierses.Paginas;                                      //Package
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import com.example.android.xyztouristattractions.R;
import java.io.Serializable;

import com.litierses.Controladores.DietaManager;                    //controlador
import com.litierses.Entidades.Dieta;                               //Parametro del Page (tipo)
//Para collections
import java.util.ArrayList;
//Para Datatable
import android.support.v7.widget.RecyclerView;
import android.content.Context;
import com.litierses.Utilidades.SinDatosRecyclerView;
import com.litierses.Utilidades.UtilityService;
import android.content.BroadcastReceiver;
import android.location.Location;
import android.content.Intent;
import com.google.android.gms.location.FusedLocationProviderApi;
import android.support.v4.content.LocalBroadcastManager;

//Para componentes Label
import android.widget.Button;
import android.widget.TextView;


public class DietaList_Fragment extends Fragment {                   //nombre del Page + _fragment

    private static final String EXTRA_OBJECT = "DietaList_object";                           // nombre Page
    private ArrayList<Dieta> dietas;                                               //Parametro del Page (tipo)
    // Cuando Tiene DataTable
    private AttractionAdapter mAdapter;
    private boolean mItemClicked;

    public static DietaList_Fragment createInstance(ArrayList<Dieta> dietas) {     //nombre del Page + _fragment //Parametro del Page (tipo+nombre)
        DietaList_Fragment detailFragment = new DietaList_Fragment();   //nombre del Page + _fragment
        Bundle bundle = new Bundle();
        bundle.putSerializable(EXTRA_OBJECT, (Serializable) dietas);     //Parametro del Page (nombre)
        detailFragment.setArguments(bundle);
        return detailFragment;
    }

    public DietaList_Fragment() {}                       //nombre del Page + _fragment
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        setHasOptionsMenu(true);
        View view = inflater.inflate(R.layout.dietalist_fragment, container, false);       //nombre del Page + _fragment (minuscula)
        dietas = (ArrayList<Dieta>) getArguments().getSerializable(EXTRA_OBJECT);                  //Parametro del Page (tipo+nombre)

        if (dietas == null) { getActivity().finish();       return null;     }

//CUANDO TIENE DATATABLE Se reemplaza todo de cada en adelante

        AttractionAdapter mAdapter = new AttractionAdapter(getActivity(), dietas);                        //Parametro del Page (nombre)
        SinDatosRecyclerView recyclerView = (SinDatosRecyclerView) view.findViewById(R.id.DataTable);      //nombre componente DataTAble
        recyclerView.setEmptyView(view.findViewById(R.id.DataTable_empty));                                //nombre componente DataTAble
        recyclerView.setHasFixedSize(true);
        recyclerView.setAdapter(mAdapter);

        return view;
    }

    interface ItemClickListener {void onItemClick(View view, int position, String boton); }

    @Override
    public void onResume() {
        super.onResume();
        mItemClicked = false;
        LocalBroadcastManager.getInstance(getActivity()).registerReceiver( mBroadcastReceiver, UtilityService.getLocationUpdatedIntentFilter());
    }

    @Override
    public void onPause() {
        super.onPause();
        LocalBroadcastManager.getInstance(getActivity()).unregisterReceiver(mBroadcastReceiver);
    }

    private BroadcastReceiver mBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            Location location =
                    intent.getParcelableExtra(FusedLocationProviderApi.KEY_LOCATION_CHANGED);
            //if (location != null) {
                mAdapter.dietas = dietas;                                       //Parametro del Page (nombre)
                //mAdapter.notifyDataSetChanged();
            //}
        }
    };

    //*****************************************************************************************************//
                //SUB CLASE
    //*****************************************************************************************************//
    private class AttractionAdapter extends RecyclerView.Adapter<ViewHolder>   implements ItemClickListener {

        public ArrayList<Dieta> dietas;                  //Parametro del Page (tipo+nombre)
        private Context mContext;

        public AttractionAdapter(Context context, ArrayList<Dieta> dietas) {      //Parametro del Page (tipo+nombre)
            super();
            mContext = context;
            this.dietas = dietas;                       //Parametro del Page (nombre)
        }

        @Override
        public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            LayoutInflater inflater = LayoutInflater.from(mContext);
            View view = inflater.inflate(R.layout.list_row, parent, false);         // Page relacionado RESOLVER!!!!!!!!
            return new ViewHolder(view, this);
        }

        @Override
        public void onBindViewHolder(ViewHolder holder, int position) {
            Dieta dieta = dietas.get(position);             //Parametro del for (tipo+nombre) + Parametro del Page (tipo+nombre)

            holder.mTitleTextView.setText(dieta.nombre);                          //Atributos asignados en el for
            holder.mDescriptionTextView.setText(dieta.desayuno);
            holder.mtext3.setText(dieta.almuerzo);
            holder.mtext4.setText(dieta.cena);
            holder.mtext5.setText(dieta.merienda);
            holder.mtext6.setText(dieta.patologia + "");
        }
        @Override
        public long getItemId(int position) {       return position;  }
        @Override
        public int getItemCount() {
            return dietas == null ? 0 : dietas.size();  // Parametro del Page (tipo+nombre)
        }
        @Override
        public void onItemClick(View view, int position,String boton) {
            if (!mItemClicked) {
                mItemClicked = true;
                View heroView = view.findViewById(android.R.id.icon);

                if (boton.equals("View")) {                        //  nombre boton en el for
                    System.out.println("Position: "+position);
                    DietaManager.viewDieta(getActivity(), dietas.get(position)); //evento de boton
                }
                if (boton.equals("Edit")) {               //  nombre boton en el for
                    DietaManager.editDieta(getActivity(), dietas.get(position)); //evento de boton
                }
                if (boton.equals("Delete")) {               //  nombre boton en el for
                    DietaManager.deleteDieta(getActivity(), dietas.get(position)); //evento de boton
                    //DietaManager.deleteDieta(getActivity(), (position)); //evento de boton
                }
            }
        }


    }
    //*****************************************************************************************************//
    //SUB CLASE
    //*****************************************************************************************************//

    private static class ViewHolder extends RecyclerView.ViewHolder   {

        ItemClickListener mItemClickListener;

        TextView mTitleTextView;                    //Atributos asignados en el for
        TextView mDescriptionTextView;
        TextView mOverlayTextView;
        TextView mtext3;
        TextView mtext4;
        TextView mtext5;
        TextView mtext6;
        Button View;
        Button Edit;
        Button Delete;

        public ViewHolder(View view, ItemClickListener itemClickListener) {
            super(view);
            mItemClickListener = itemClickListener;
            mTitleTextView = (TextView) view.findViewById(android.R.id.text1);          //Atributos asignados en el for
            mDescriptionTextView = (TextView) view.findViewById(android.R.id.text2);
            mtext3 = (TextView) view.findViewById(R.id.text3);
            mtext4 = (TextView) view.findViewById(R.id.text4);
            mtext5 = (TextView) view.findViewById(R.id.text5);
            mtext6 = (TextView) view.findViewById(R.id.text6);
            View = (Button)view.findViewById(R.id.View);
            Edit = (Button)view.findViewById(R.id.Edit);
            Delete = (Button)view.findViewById(R.id.Delete);


            View.setOnClickListener(new View.OnClickListener() {                        //por cada boton
                @Override
                public void onClick(View v) {
                    mItemClickListener.onItemClick(v, getAdapterPosition(),"View");       //nombre del boton
                }
            });

            Edit.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    mItemClickListener.onItemClick(v, getAdapterPosition(),"Edit");       //nombre del boton
                }
            });

            Delete.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    mItemClickListener.onItemClick(v, getAdapterPosition(),"Delete");       //nombre del boton
                }
            });


        }

    }


}
