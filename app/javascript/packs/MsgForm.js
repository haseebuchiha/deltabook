import { makeStyles, Box } from '@material-ui/core'
import React, { useState } from 'react'
const useStyles = makeStyles({
    createMsg: {
        height: "60px",
        backgroundColor: "#1e3a61",
        padding: "10px",
        display: "flex",
        justifyContent: "space-evenly",
        alignItems: "center",
    },
    msgInput: {
        width: "80%",
        border: "none",
        outline: "none",
        padding: "8px",
        borderRadius: "4px"
    },

    btn: {
        border: "none",
        borderRadius: "4px",
        outline: "none",
        color: "#fff",
        backgroundColor: "transparent",
        transition: "all 0.5s ease-out",
        '&:hover': {
            backgroundColor: "#fff",
            color: "#1e3a61",
        },
    },
})
const MsgForm = () => {
    const classes = useStyles()
    const [body, setBody] = useState('')

    function onTextFieldChange(e) {
        setBody({
         [e.target.name]: e.target.value
        })
    }

    async function onFormSubmit(e) {
        e.preventDefault()
        try {
            const response = await window.fetch('http://localhost:3000/api/messages', {
              method: 'post',
              headers: {
                'Content-Type': 'application/json',
              },
              body: JSON.stringify(body),
            });

            if (!response.ok){
              const err = await response.json()
              console.log(err)
            }else{
              e.target.body.value = "";
            }
        } 
        catch (error) {
            console.error(error)
        }
    }
  return (
    <>
    <form className={classes.createMsg} onSubmit={e => {onFormSubmit(e)}}>
        <input className={classes.msgInput} type='text' name="body" placeholder='Enter the message' onChange={e => (onTextFieldChange(e))}/>
        <Box>
            <button className={classes.btn}><i className="fa-solid fa-paper-plane" style={{padding: "8px 14px", fontSize:"24px"}}></i></button>
        </Box>
    </form>
    </>
  )
}

export default MsgForm