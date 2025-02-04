{ lib
, buildPythonPackage
, email-validator
, fastapi
, fetchFromGitHub
, httpx
, oauthlib
, poetry-core
, pydantic
, pylint
, pytest-asyncio
, pytest-xdist
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "fastapi-sso";
  version = "0.11.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "tomasvotava";
    repo = "fastapi-sso";
    rev = "refs/tags/${version}";
    hash = "sha256-bz4rr7h90d/QkBBqQN1pLF8ANhOiq2v0Vv2pjBGpeTs=";
  };

  postPatch = ''
    sed -i "/--cov/d" pyproject.toml
  '';

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    fastapi
    httpx
    oauthlib
    pydantic
    pylint
  ];

  nativeCheckInputs = [
    email-validator
    pytest-asyncio
    pytest-xdist
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "fastapi_sso"
  ];

  meta = with lib; {
    description = "FastAPI plugin to enable SSO to most common providers (such as Facebook login, Google login and login via Microsoft Office 365 Account";
    homepage = "https://github.com/tomasvotava/fastapi-sso";
    changelog = "https://github.com/tomasvotava/fastapi-sso/releases/tag/${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
