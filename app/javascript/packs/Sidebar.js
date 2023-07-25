import { Box, Typography, makeStyles } from '@material-ui/core'
import React, { useEffect, useState } from 'react'
import axios from 'axios'
import './App.css'
const useStyles = makeStyles({
    // sidebar:{
    //     flex: "1",
    //     backgroundColor: "#eee",
    //     position: "absolute",
    //     width: "250px",
    //     overflow: "hidden",
    //     transition: "all 0.5s ease",
    //     height: "100%"
    // },
    img: {
        width: "50px",
        height: "50px",
        borderRadius: "50%",
    },
    userInfo: {
        fontSize: "18px",
        fontWeight: "bold",
    },
    userEmail: {
        fontSize: "14px",
    }
})
const Sidebar = () => {
    const classes = useStyles()
    const [clicked, setClicked] = useState(true) 
    const[users , setUsers] = useState([])

    useEffect(()=>{
        axios.get("/api/messages").then((res) => {
            setUsers(res.data)
        })
    },[])

  return (
    <>
        <Box className={clicked ? 'icon' : 'icon active'}  onClick={() => setClicked(!clicked)}>
            <i className={clicked ? 'fa-solid fa-circle-chevron-right':'fa-solid fa-circle-chevron-left'} style={{fontSize: "24px",fontWeight:"bold",color:"#1e3a61"}}></i>
        </Box>
        <Box  id='#msg' className={clicked ? 'sidebar' : 'sidebar active'}>
        {users.map((item)=>(
            <Box sx={{display: "flex", padding: "10px", alignItems: "center"}}>
                <img className={classes.img} src='https://www.clarity-enhanced.net/wp-content/uploads/2020/06/filip.jpg' />
                <Box sx={{ml: 1}}>
                    <Typography className={classes.userInfo}>{item.username}</Typography>
                    <Typography className={classes.userEmail}>{item.email}</Typography>
                </Box>
            </Box>
        ))}
        </Box>
        
    </>
  )
}

export default Sidebar