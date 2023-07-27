import React from "react";
import FormFeed from "./Form";
import { useState, useEffect } from "react";
import { useParams, Link, useNavigate } from "react-router-dom";
import axios from "axios";

const EditFeed = () => {
    const [feed, setFeed] = useState({})
    const navigate = useNavigate()
    const params = useParams()

    useEffect(() => {
        const id = params.id
        const url = `/api/v1/feeds/${id}`
        axios.get(url)
            .then(resp => {
                setFeed(resp.data)
            })
            .catch(resp => console.log(resp))
    }, [])

    const handleChange = (e) => {
        e.preventDefault()
        setFeed(Object.assign({}, feed, { [e.target.name]: e.target.value }))
    }

    const handleSubmit = (e) => {
        e.preventDefault()

        axios.post('/api/v1/feeds', { feed })
            .then(resp => {
                navigate(`/feed/${resp.data.id}`)
            })
            .catch(resp => { console.log(resp) })
    }

    return (
        <div className="container">
            <h3 className="text-center mb-4">Edit Feed</h3>
            <FormFeed
                handleChange={handleChange}
                handleSubmit={handleSubmit}
                feed={feed}
            />
            <div className="text-center">
                <Link to={`/feeds`} className="btn btn-outline-dark btn-lg mt-5">Back to Feeds</Link>
            </div>
        </div>
    )
}

export default EditFeed;
