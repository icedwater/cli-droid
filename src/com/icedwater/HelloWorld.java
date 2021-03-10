package com.icedwater;
import android.widget.TextView;

public final class HelloWorld extends android.app.Activity
{
    protected @Override void onCreate(final android.os.Bundle activityState)
    {
        super.onCreate(activityState);
        final TextView textV = new TextView(HelloWorld.this);
        textV.setText("Hello World.");
        setContentView(textV);
    }
}
