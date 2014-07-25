using UnityEngine;
using System.Collections;


public class SendButton : MonoBehaviour {

	// Use this for initialization
	SpacebrewClient sbClient;

	// Use this for initialization
	void Start () {
        // Need reference to object so we can publish from a button click.
		GameObject go = GameObject.Find ("SpacebrewObject"); // the name of your client object
        sbClient = go.GetComponent<SpacebrewClient>();
	}


    public void OnSpacebrewEvent(SpacebrewClient.SpacebrewMessage _msg)
    {

        GameObject.Find("subscribeText").guiText.text = _msg.value;
    }



    void OnMouseDown() {

        sbClient.sendMessage("button_pressed", "string", "on");
    }

    void OnMouseUp() {
       sbClient.sendMessage("button_pressed", "string", "off");
    }
	
}
