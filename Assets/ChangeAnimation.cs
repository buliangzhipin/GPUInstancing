using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeAnimation : MonoBehaviour
{
    private MaterialPropertyBlock mpb = null;
    private Renderer ren = null;
    void Awake()
    {
        this.mpb = new MaterialPropertyBlock();
        this.ren = this.GetComponent<Renderer>();
    }

    public void ChangeAnimator(int type)
    {
        this.mpb.SetInt("_Type", type);
        this.ren.SetPropertyBlock(this.mpb);
    }
}
