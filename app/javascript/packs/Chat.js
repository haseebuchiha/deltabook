import { Box, Container, Typography, makeStyles, Button } from '@material-ui/core'
import React, { useEffect, useState, useRef} from 'react'
import axios from 'axios'
import MsgForm from './MsgForm'
import ChatroomChannel from '../channels/chatroom_channel'
const useStyles = makeStyles({
    chat: {
        flex: "2",
        
    },
    chatUser: {
        display: "flex",
        justifyContent: "space-between",
        alignItems: "center",
        padding: "8px",
        background: "#1e3a61",
        color: "#fff",
    },
    img: {
        width: "50px",
        height: "50px",
        borderRadius: "50%",
    },
    messages: {
        height: "calc(100% - 126px)", 
        overflowY: "scroll",
        padding: "0 4px"
    },
    msg: {
        display: "inline-block",
        margin: "4px",
        padding: "6px 4px",
        border: "1px solid #2e568f",
        borderRadius: "4px",
        backgroundColor: "#2e568f",
        color: "#fff",
    },
    user: {
        margin: "2px 4px",
        fontWeight: "bold",
    },
    msgWrapper: {
        textAlign: "end"
    }

    
})
const Chat = () => {
    const classes = useStyles()
    const [messages , setMessages] = useState([])
    const [users , setUsers] = useState([])
    const [logged, setLogged] = useState([])
    const bottomRef = useRef()

    useEffect(()=>{
        axios.get("/api/msg").then((res)=>{
            setMessages(res.data.messages)
            setUsers(res.data.users)
            setLogged(res.data.currentuser)
        })
    },[])

    useEffect(() => {
        bottomRef.current.scrollIntoView({ behavior: "smooth" });
    }, [messages]);

    ChatroomChannel.received = (data) => {
        setMessages([...messages, data.mod_msg]) 
    }
 
    
  return (
    <>
        <Box className={classes.chat}>
            <Box className={classes.chatUser}>
                <Box sx={{display:"flex", alignItems:"center"}}>
                    <img className={classes.img} src='https://www.clarity-enhanced.net/wp-content/uploads/2020/06/filip.jpg' />
                    <Typography style={{marginLeft: "8px", fontWeight: "600"}}>{logged.username}</Typography>
                </Box>
                <Box>
                    <i className="fa-solid fa-user" style={{padding: "10px"}}></i>
                    <i className="fa-solid fa-ellipsis-vertical" style={{padding: "10px"}}></i>
                </Box>
            </Box>
            <Box id='msg' className={classes.messages}>
                {messages.map((item)=>(
                    <>
                        {users.filter((user => user.id == item.user_id)).map((x) =>(
                            
                            <Typography className={classes.user}>{x.username}</Typography>

                        ))}
                        
                        <Typography className={classes.msg}>{item.body}</Typography><br/>
                    </>
                ))}
                <div id="bottom-reference" ref={bottomRef} />
            </Box>

            <MsgForm />

        </Box>
        
    </>
  )
}

export default Chat