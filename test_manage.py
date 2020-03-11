import pytest
import manage

@pytest.fixture
def client():
    manage.app.config['TESTING'] = True

    with manage.app.test_client() as client:
        yield client
def test_index(client):
    rv = client.get('/')
    assert(rv.data.decode('UTF-8') == 'v1')
