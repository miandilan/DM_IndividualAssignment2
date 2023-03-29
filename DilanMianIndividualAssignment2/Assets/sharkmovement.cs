using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class sharkmovement : MonoBehaviour
{
    public float speed = 5f;
    public GameObject plane;

    private Vector3 planeNormal;

    void Start()
    {
        //get the normal of the plane object
        planeNormal = plane.transform.up;
    }

    void Update()
    {
        //get the horizontal and vertical axis input
        float horizontalInput = Input.GetAxis("Horizontal");
        float verticalInput = Input.GetAxis("Vertical");

        //calculate the movement direction based on the input
        Vector3 movementDirection = new Vector3(horizontalInput, 0f, verticalInput);

        //if there is input, move the object
        if (movementDirection != Vector3.zero)
        {
            //clamp the movement direction to the plane
            movementDirection = Vector3.ProjectOnPlane(movementDirection, planeNormal).normalized;

            //move the object
            transform.position += movementDirection * speed * Time.deltaTime;
        }
    }
}

