with open("requirements.txt", "r") as f:
    requirements = f.readlines()
    
requirements = [r.strip() for r in requirements]
# requirements = [r for r in requirements if r and not r.startswith("#")]
# requirements = [r for r in requirements if not r.count("git+")]
# requirements = [r for r in requirements if not r.count("http://")]
# requirements = [r for r in requirements if not r.count("https://")]

requirements = [r.split("==")[0] for r in requirements if not r.count("git+") or not r.count("http://") or not r.count("https://")]

with open("requirements-pip.txt", "w") as f:
    f.write("\n".join(requirements))