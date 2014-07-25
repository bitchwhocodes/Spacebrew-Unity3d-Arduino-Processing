using UnityEngine;
using System.Collections;

public class SpacebrewEvents : MonoBehaviour {

	SpacebrewClient sbClient;

	// Use this for initialization
	void Start () {
		GameObject go = GameObject.Find ("SpacebrewObject"); // the name of your client object
		sbClient = go.GetComponent <SpacebrewClient> ();

		// register an event with the client and a callback function here.
		// COMMON GOTCHA: THIS MUST MATCH THE NAME VALUE YOU TYPED IN THE EDITOR!!
        sbClient.addEventListener(this.gameObject, "button_pressed");
	}

	public void OnSpacebrewEvent(SpacebrewClient.SpacebrewMessage _msg) {
		
        GameObject.Find("subscribeText").guiText.text = _msg.value;
	}

}
