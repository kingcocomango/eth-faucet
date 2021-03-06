import React, { Component } from 'react'

import { Row, Col } from 'react-grid-system';

import {Card, CardTitle, CardText} from 'material-ui/Card';

import PageContainer from '../containers/PageContainer';

class HomePage extends Component {
  render() {
    return(
      <PageContainer>
        <Row>
          <Col xs={12}>
            <Card>
              <CardTitle title="Faucet stuff" subtitle="Other faucet stuff" />
              <CardText>
                <img src="/faucet.png" alt="logo" style={{
                  display: 'block',
                  width: '200px',
                  margin: 'auto auto 15px auto',
                }}/>
                Orie == Scrub Jr.
              </CardText>
            </Card>
          </Col>
        </Row>
      </PageContainer>
    )
  }
}

export default HomePage
