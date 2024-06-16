update-deps:
	.venv/bin/python -m pip install --upgrade uv
	.venv/bin/python -m uv pip freeze | .venv/bin/python -m uv pip compile - --upgrade -o requirements.txt

venv:
	python -m pip install --upgrade uv
	python -m uv venv

poetry:
	python -m pip install --upgrade poetry
	python -m poetry update
	python -m poetry install --no-root
	python -m poetry shell

clean:
	rm -rf .venv
	rm poetry.lock
	y | python -m poetry cache clear --all .
	python -m uv cache clean

lock:
	python -m poetry lock --no-update

uv-install:
	rm -rf .tox
	.venv/bin/python -m pip install --upgrade uv
	.venv/bin/python -m uv pip install --upgrade -r requirements.txt 
	.venv/bin/python -m uv pip check

update: update-deps uv-install

full_update: clean lock poetry 

.PHONY: update-deps init update

