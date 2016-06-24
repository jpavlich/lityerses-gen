	
package com.litierses.pages;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.location.Location;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.content.LocalBroadcastManager;
import android.support.v7.widget.RecyclerView;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.engine.DiskCacheStrategy;
import com.example.android.xyztouristattractions.R;
import com.litierses.entidad.Attraction;
import com.litierses.services.Constants;
import com.litierses.services.Utils;
import com.litierses.controlador.TouristAttractions;
import com.litierses.services.UtilityService;
import com.google.android.gms.location.FusedLocationProviderApi;
import com.google.android.gms.maps.model.LatLng;
import com.google.maps.android.SphericalUtil;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import static com.litierses.controlador.TouristAttractions.ATTRACTIONS;

public class AttractionListFragmentNew extends Fragment {

    private AttractionAdapter mAdapter;
    private LatLng mLatestLocation;
    private int mImageSize;
    private boolean mItemClicked;

    public AttractionListFragmentNew() {}

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Load a larger size image to make the activity transition to the detail screen smooth
        mImageSize = getResources().getDimensionPixelSize(R.dimen.image_size) * Constants.IMAGE_ANIM_MULTIPLIER;
        
        
        List<AttractionNew> attractions = loadAttractionsFromLocation(mLatestLocation);
        mAdapter = new AttractionAdapter(getActivity(), attractions);
        View view = inflater.inflate(R.layout.fragment_main, container, false);
        AttractionsRecyclerView recyclerView =
                (AttractionsRecyclerView) view.findViewById(android.R.id.list);
        recyclerView.setEmptyView(view.findViewById(android.R.id.empty));
        recyclerView.setHasFixedSize(true);
        recyclerView.setAdapter(mAdapter);
        return view;
    }

    @Override
    public void onResume() {
        super.onResume();
        mItemClicked = false;
        LocalBroadcastManager.getInstance(getActivity()).registerReceiver(
                mBroadcastReceiver, UtilityService.getLocationUpdatedIntentFilter());
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
            if (location != null) {
                mLatestLocation = new LatLng(location.getLatitude(), location.getLongitude());
                mAdapter.mAttractionList = loadAttractionsFromLocation(mLatestLocation);
                mAdapter.notifyDataSetChanged();
            }
        }
    };

    //
    private static List<AttractionNew> loadAttractionsFromLocation(final LatLng curLatLng) {
        List<<AttractionNew> attractions = ATTRACTIONS.get("Bogotá");
        return attractions;
    }


    //*****************************************************************************************************//
                //SUB CLASE
    //*****************************************************************************************************//
    private class AttractionAdapter extends RecyclerView.Adapter<ViewHolder>   implements ItemClickListener {

    	//
        public List<AttractionNew> mAttractionList;
        private Context mContext;
//
        public AttractionAdapter(Context context, List<AttractionNew> attractions) {
            super();
            mContext = context;
            mAttractionList = attractions;
        }

        @Override
        public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            LayoutInflater inflater = LayoutInflater.from(mContext);
            View view = inflater.inflate(R.layout.list_row, parent, false);
            return new ViewHolder(view, this);
        }

        @Override
        public void onBindViewHolder(ViewHolder holder, int position) {
        	//
            <AttractionNew attraction = mAttractionList.get(position);

            //
            holder.mTitleTextView.setText(attraction.name);
            //
            holder.mDescriptionTextView.setText(attraction.description);
            //
            Glide.with(mContext)
                    .load(attraction.imageUrl)
                    .diskCacheStrategy(DiskCacheStrategy.SOURCE)
                    .placeholder(R.drawable.empty_photo)
                    .override(mImageSize, mImageSize)
                    .into(holder.mImageView);

            String distance =
                    Utils.formatDistanceBetween(mLatestLocation, attraction.location);
            if (TextUtils.isEmpty(distance)) {
                holder.mOverlayTextView.setVisibility(View.GONE);
            } else {
                holder.mOverlayTextView.setVisibility(View.VISIBLE);
                holder.mOverlayTextView.setText(distance);
            }
        }

        @Override
        public long getItemId(int position) {
            return position;
        }

        @Override
        public int getItemCount() {
            return mAttractionList == null ? 0 : mAttractionList.size();
        }

        @Override
        public void onItemClick(View view, int position) {
            if (!mItemClicked) {
                mItemClicked = true;
                View heroView = view.findViewById(android.R.id.icon);
                DetailActivity.launch(
                        getActivity(), mAdapter.mAttractionList.get(position).name, heroView);
            }
        }
    }
    //*****************************************************************************************************//
    //SUB CLASE
    //*****************************************************************************************************//

    private static class ViewHolder extends RecyclerView.ViewHolder
            implements View.OnClickListener {

        TextView mTitleTextView;
        TextView mDescriptionTextView;
        TextView mOverlayTextView;
        ImageView mImageView;
        ItemClickListener mItemClickListener;

        public ViewHolder(View view, ItemClickListener itemClickListener) {
            super(view);
            mTitleTextView = (TextView) view.findViewById(android.R.id.text1);
            mDescriptionTextView = (TextView) view.findViewById(android.R.id.text2);
            mOverlayTextView = (TextView) view.findViewById(R.id.overlaytext);
            mImageView = (ImageView) view.findViewById(android.R.id.icon);
            mItemClickListener = itemClickListener;
            view.setOnClickListener(this);
        }

        @Override
        public void onClick(View v)
        {
            mItemClickListener.onItemClick(v, getAdapterPosition());
        }
    }

    interface ItemClickListener {
        void onItemClick(View view, int position);
    }
}
	
		
