import React, { useState, useEffect } from 'react'
import { useParams, Link, useNavigate } from 'react-router-dom'
import axios from 'axios'

const Feed = (props) => {
    const [feed, setFeed] = useState({})
    const navigate = useNavigate()
    const params = useParams()

    useEffect(() => {
        const id = params.id
        const url = `/api/v1/feeds/${id}`
        axios.get(url)
            .then(resp => setFeed(resp.data))
            .catch(resp => console.log(resp))
    }, [])

    const handleDestroy = (e) => {
        const id = params.id
        axios.delete(`/api/v1/feeds/${id}`)
            .then(resp => {
                navigate("/feeds")
            })
            .catch(resp => console.log(resp))
    }

    return <div className="container">
        <h3 className="text-center">Showing Feed</h3>
        <div className="col card text-center mt-4 rounded-lg shadow">
            <div className="row">

                <div className="col col-2 bg-dark text-white d-flex justify-content-center align-items-center">
                    <h5 className="mb-3"><small>by</small><br />Random User</h5>
                </div>

                <div className="col col-10">
                    <div className="card-body">
                        <h5 className="card-title">{feed.title}</h5>
                        <hr />
                        <p className="card-text">{feed.description}</p>
                    </div>
                    <div className="d-flex justify-content-center">
                        <Link to={`/feed/${feed.id}/edit`} className="btn btn-outline-success mx-2">Edit</Link>
                        <button onClick={handleDestroy} className="btn btn-outline-danger mx-2">Delete</button>
                    </div>
                    <hr />
                    <div className="text-muted mb-3">
                        <small> Create {feed.created_at} ago,
                            edited {feed.updated_at} ago</small>
                    </div>
                </div>
            </div>
        </div>
        <div className="text-center">
            <Link to={`/feeds`} className="btn btn-outline-dark btn-lg mt-5">Back to Feeds</Link>
        </div>
    </div>
}

export default Feed;