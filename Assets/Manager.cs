using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Manager : MonoBehaviour
{
    public ChangeAnimation animator;
    public GameObject testAnimator;
    // Start is called before the first frame update
    void Start()
    {
        // for(int i = 0;i<100;i++)
        // {
        //     var obeject = Instantiate(animator);
        //     obeject.transform.localPosition = new Vector3(i,0,i%10);
        //     obeject.ChangeAnimator(1);            
        // }
                    for(int i = 0;i<100;i++)
                    {
                        var obeject = Instantiate(testAnimator);
                        var anima = obeject.GetComponentInChildren<Animation>();
                        // anima.SendMessage();
                        obeject.transform.localPosition = new Vector3(i,0,i%10);          
                    }

    }

}
