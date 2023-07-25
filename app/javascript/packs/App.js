import React, { useState } from 'react'
import {Container, Grid, Box, Typography, Button, makeStyles,List,ListItem} from '@material-ui/core'
import Sidebar from './Sidebar'
import Chat from './Chat'
const useStyles = makeStyles({
    chatApp: {
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        height: "85vh"
    },
    wrapper: {
        borderRadius: "10px",
        position: "relative",
        width: "65%",
        height: "90%",
        display: "flex",
        overflow: "hidden",
        boxShadow: "2px 2px 15px 3px rgba(0,0,0,0.75)",
    },
    title: {
        textAlign: "center",
        fontSize: "32px",
        textTransform: "uppercase",
        color: "#2C3E50",
        marginBottom: "10px",
        letterSpacing: "2px",
        fontWeight: "bold"
    }
})
const App = () => {
    const classes = useStyles()
  return (
    <>
        <Typography variant='h3' className={classes.title}>ChatApp</Typography>
        <Container className={classes.chatApp}>
            <Box className={classes.wrapper}>
                <Sidebar />
                <Chat />
            </Box>
        </Container>
        
    </>
  )
}

export default App