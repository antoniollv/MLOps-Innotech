import requests


def test_service():
    prediction = requests.post(
        'http://127.0.0.1:8000/employee/predict',
        headers={'content-type': 'application/json'},
        data='{"City": "Pune", "PaymentTier": 0, "Age": 0, "Gender": "Female", "EverBenched": "No", "ExperienceInCurrentDomain": 0}',
    ).text

    assert prediction[0] in ['0', '1']



