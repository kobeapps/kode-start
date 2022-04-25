import './App.css';
import React from 'react';
import { client } from "./client"
import Card from './components/Card';

class App extends React.Component {
  state = {
    articles:[],
  };
  componentDidMount(){
    client.getEntries()
    .then((response) => {
      console.log(response)
      this.setState({
        articles:response.items
      })
    })
    .catch(console.error)
  }

  render() {
    return( 
      <div>
      <h1> hello world </h1>
     </div>
    ) 
  }
}

export default App;
