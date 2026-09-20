import unittest

from app.app import app


class TestApp(unittest.TestCase):

    def setUp(self):
        app.config["TESTING"] = True
        self.client = app.test_client()

    def test_home(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json["status"], "healthy")

    def test_health(self):
        response = self.client.get("/health")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json["status"], "healthy")

    def test_info(self):
        response = self.client.get("/info")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json["application"], "DockerTaskApp")


if __name__ == "__main__":
    unittest.main()
