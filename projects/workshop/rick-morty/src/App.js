import "./App.css";
import React from "react";
import { client } from "./client";
import Cards from "./components/Cards";

class App extends React.Component {
  state = {
    details: [],
  };
  componentDidMount() {
    client
      .getEntries()
      .then((response) => {
        console.log(response);
        this.setState({
          details: response.items,
        });
      })
      .catch(console.error);
  }

  render() {
    return (
      <div className="app">
        <div className="container">
          <header>
            <div className="wrapper">
              <h1>API Rick and Morty - Contentful</h1>
            </div>
          </header>

          <main>
            <div className="wrapper card">
              <Cards cards={this.state.details} />
            </div>
          </main>
        </div>
      </div>
    );
  }
}

export default App;
