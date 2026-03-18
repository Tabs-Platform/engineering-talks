locals {
  custom_css = <<-CSS
    @import url('https://fonts.googleapis.com/css2?family=Fira+Code:wght@400;600&display=swap');

    :root {
      --green: #00ff41;
      --amber: #ffb000;
      --bg: #0a0a0a;
      --fg: #e0e0e0;
      --code-bg: #1a1a2e;
    }

    body, .reveal {
      background-color: var(--bg);
      font-family: 'Fira Code', 'Courier New', monospace;
    }

    .reveal h1, .reveal h2, .reveal h3 {
      color: var(--green);
      font-family: 'Fira Code', 'Courier New', monospace;
      text-transform: none;
      font-weight: 600;
      letter-spacing: -0.02em;
    }

    .reveal h1 { font-size: 1.8em; }
    .reveal h2 { font-size: 1.4em; }
    .reveal h3 { font-size: 1.1em; }

    .reveal p, .reveal li, .reveal td {
      color: var(--fg);
      text-align: left;
      font-size: 0.7em;
      line-height: 1.6;
    }

    .reveal ul, .reveal ol {
      display: block;
      margin-left: 1em;
    }

    .reveal .amber { color: var(--amber); }
    .reveal .green { color: var(--green); }
    .reveal .dim { color: #666; }

    .reveal pre {
      width: 95%;
      margin: 0.5em auto;
    }

    .reveal pre code {
      font-size: 0.55em;
      line-height: 1.5;
      background: var(--code-bg);
      border: 1px solid var(--green);
      border-radius: 4px;
      padding: 0.8em;
      max-height: 500px;
    }

    .reveal code:not(pre code) {
      color: var(--amber);
      font-size: 0.9em;
      background: rgba(255, 176, 0, 0.1);
      padding: 0.1em 0.3em;
      border-radius: 3px;
    }

    .reveal .slide-number {
      color: var(--green);
      font-family: 'Fira Code', monospace;
      font-size: 0.5em;
    }

    .tf-plan {
      font-family: 'Fira Code', monospace;
      text-align: left;
      font-size: 0.65em;
      line-height: 1.8;
    }

    .tf-plan .resource { color: var(--green); }
    .tf-plan .comment { color: #666; }

    .reveal .prompt::before {
      content: '$ ';
      color: var(--amber);
    }

    .reveal blockquote {
      border-left: 4px solid var(--amber);
      background: rgba(255, 176, 0, 0.05);
      padding: 0.5em 1em;
      width: 85%;
    }

    .reveal table {
      margin: 0.5em auto;
      border-collapse: collapse;
    }

    .reveal table th {
      color: var(--green);
      border-bottom: 2px solid var(--green);
      padding: 0.4em 0.8em;
      font-size: 0.65em;
    }

    .reveal table td {
      border-bottom: 1px solid #333;
      padding: 0.4em 0.8em;
      font-size: 0.6em;
    }

    .reveal .section-header {
      border-bottom: 2px solid var(--green);
      padding-bottom: 0.3em;
      margin-bottom: 0.5em;
    }
  CSS

  slides = <<-HTML

    <!-- ============================================ -->
    <!-- SLIDE 1: terraform init — Title              -->
    <!-- ============================================ -->
    <section>
      <p style="color: var(--amber); font-size: 0.7em; margin-bottom: 0;">$ terraform init</p>
      <p style="color: #666; font-size: 0.55em;">Initializing provider plugins...</p>
      <p style="color: var(--green); font-size: 0.55em;">✓ Terraform has been successfully initialized!</p>
      <br>
      <h1>${var.talk_title}</h1>
      <p style="color: var(--green); font-size: 0.8em; text-align: center;">${var.presenter_name}</p>
      <aside class="notes">
        Welcome, everyone. Quick meta-note: this presentation was literally provisioned with terragrunt apply —
        every slide you see is a resource attribute in a .tf file, wrapped by Terragrunt. So if there's a typo, blame the state file.
        Let's get started.
      </aside>
    </section>

    <!-- ============================================ -->
    <!-- SLIDE 2: terraform plan — Table of Contents  -->
    <!-- ============================================ -->
    <section>
      <h2 class="prompt">terraform plan</h2>
      <div class="tf-plan">
        <p class="comment"># Terraform will perform the following actions:</p>
        <br>
        <p class="resource">+ slide.history_of_terraform</p>
        <p class="resource">+ slide.why_terraform</p>
        <p class="resource">+ slide.core_concepts</p>
        <p class="resource">+ slide.writing_terraform</p>
        <p class="resource">+ slide.terragrunt</p>
        <p class="resource">+ slide.cicd_at_tabs</p>
        <br>
        <p>Plan: <span class="amber">8 slides</span> to add, <span class="amber">0</span> to change, <span class="amber">0</span> to destroy.</p>
      </div>
      <aside class="notes">
        Here's our roadmap. We're using the Terraform lifecycle as the framing device.
        Each of these "resources" is a section we'll walk through.
      </aside>
    </section>

    <!-- ============================================ -->
    <!-- terraform apply — Main Content Begins        -->
    <!-- ============================================ -->

    <!-- SLIDE 3: History of Terraform -->
    <section>
      <section>
        <h2 class="section-header">📜 History of Terraform</h2>
        <p style="color: var(--green); font-size: 0.6em;">slide.history_of_terraform: Creating...</p>
        <aside class="notes">Let's start with how we got here. Terraform didn't appear out of nowhere — it came from a very specific vision about infrastructure.</aside>
      </section>

      <section>
        <h3>The HashiCorp Story</h3>
        <ul>
          <li><span class="amber">2012</span> — Mitchell Hashimoto and Armon Dadgar found HashiCorp</li>
          <li>Vision: a suite of tools for the full infrastructure lifecycle</li>
          <li>Vagrant (dev environments) was the first product</li>
          <li>Consul, Vault, Nomad, Packer — all part of the same ecosystem play</li>
        </ul>
        <aside class="notes">HashiCorp came out of the DevOps movement. Mitchell was already known for Vagrant. The idea was: if we can codify development environments, why not production infrastructure?</aside>
      </section>

      <section>
        <h3>Terraform Launches</h3>
        <ul>
          <li><span class="amber">July 2014</span> — Terraform 0.1 released as open source (MPL 2.0)</li>
          <li>Novel idea at the time: one tool, many cloud providers</li>
          <li>Introduced the plan → apply workflow from day one</li>
          <li><span class="amber">HCL</span> (HashiCorp Configuration Language) replaced raw JSON configs</li>
          <li>HCL designed to be human-readable while remaining machine-parseable</li>
        </ul>
        <aside class="notes">The key insight was provider-agnosticism. CloudFormation existed but only for AWS. Terraform said: let's have a single workflow regardless of where your infra lives. HCL was a big deal — JSON is painful for humans, YAML has its own problems, HCL tried to split the difference.</aside>
      </section>

      <section>
        <h3>The License Change</h3>
        <ul>
          <li><span class="amber">August 2023</span> — HashiCorp switches Terraform from MPL 2.0 to BSL 1.1 (Business Source License)</li>
          <li>BSL restricts competing commercial use; non-commercial and most production use unaffected</li>
          <li><span class="amber">September 2023</span> — Linux Foundation announces <span class="green">OpenTofu</span>, a community fork under MPL 2.0</li>
          <li>OpenTofu aims for drop-in compatibility with Terraform</li>
          <li>Most day-to-day Terraform usage is unaffected by the license change</li>
        </ul>
        <aside class="notes">This was controversial. The practical impact for most teams is minimal — BSL still allows production use. The concern was more about the precedent and long-term direction. OpenTofu exists as an insurance policy. We use Terraform proper — the BSL doesn't affect our use case.</aside>
      </section>
    </section>

    <!-- SLIDE 4: Why Terraform -->
    <section>
      <section>
        <h2 class="section-header">🤔 Why Terraform?</h2>
        <p style="color: var(--green); font-size: 0.6em;">slide.why_terraform: Creating...</p>
        <aside class="notes">So why Terraform specifically? There are other IaC tools. Let's look at what makes Terraform the choice for a lot of teams.</aside>
      </section>

      <section>
        <h3>Infrastructure as Code Principles</h3>
        <ul>
          <li><span class="amber">Declarative</span> — describe the desired end state, not the steps to get there</li>
          <li><span class="amber">Idempotent</span> — run it twice, get the same result</li>
          <li><span class="amber">Version-controlled</span> — infrastructure changes go through code review</li>
          <li><span class="amber">Self-documenting</span> — the .tf files ARE the documentation of what's deployed</li>
        </ul>
        <aside class="notes">These principles apply to all IaC tools, not just Terraform. But Terraform embodies them particularly well because of the plan/apply workflow — you always see what will change before it changes.</aside>
      </section>

      <section>
        <h3>Terraform vs. the Alternatives</h3>
        <table>
          <thead>
            <tr>
              <th></th>
              <th>Terraform</th>
              <th>CloudFormation</th>
              <th>Pulumi</th>
              <th>CDK</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="amber">Language</td>
              <td>HCL</td>
              <td>JSON / YAML</td>
              <td>Python, TS, Go…</td>
              <td>Python, TS, Go…</td>
            </tr>
            <tr>
              <td class="amber">Multi-cloud</td>
              <td class="green">Yes (native)</td>
              <td>AWS only</td>
              <td class="green">Yes</td>
              <td>AWS only</td>
            </tr>
            <tr>
              <td class="amber">Model</td>
              <td>Declarative</td>
              <td>Declarative</td>
              <td>Imperative</td>
              <td>Imperative → CFN</td>
            </tr>
            <tr>
              <td class="amber">Providers</td>
              <td class="green">3,000+</td>
              <td>~200 AWS types</td>
              <td>~150</td>
              <td>AWS constructs</td>
            </tr>
            <tr>
              <td class="amber">State</td>
              <td>Explicit (S3, etc.)</td>
              <td>Managed by AWS</td>
              <td>Explicit / managed</td>
              <td>CloudFormation</td>
            </tr>
          </tbody>
        </table>
        <aside class="notes">CloudFormation: great if you're all-in on AWS, but vendor lock-in. Pulumi: uses real programming languages which some teams prefer — but the declarative model is a feature, not a limitation, because it prevents imperative foot-guns. CDK: synthesizes to CloudFormation, so you inherit CFN's limitations. Terraform's provider ecosystem is the real moat — nearly everything has a Terraform provider.</aside>
      </section>

      <section>
        <h3>The Terraform Sweet Spot</h3>
        <ul>
          <li><span class="green">Provider ecosystem</span> — AWS, GCP, Azure, Datadog, GitHub, PagerDuty, Cloudflare… if it has an API, there's probably a provider</li>
          <li><span class="green">Plan/apply workflow</span> — see exactly what will change before it happens</li>
          <li><span class="green">State management</span> — tracks the mapping between config and real resources</li>
          <li><span class="green">Community</span> — massive module registry, extensive documentation, mature tooling</li>
          <li><span class="green">Hiring</span> — HCL is the lingua franca of infrastructure; most infra engineers know it</li>
        </ul>
        <aside class="notes">The last point matters more than people think. Choosing Terraform means your job postings say "Terraform experience" and most candidates will have it. Try hiring for Pulumi expertise — the pool is much smaller.</aside>
      </section>
    </section>

    <!-- SLIDE 5: Core Concepts -->
    <section>
      <section>
        <h2 class="section-header">🧱 Core Concepts</h2>
        <p style="color: var(--green); font-size: 0.6em;">slide.core_concepts: Creating...</p>
        <aside class="notes">Quick run through the building blocks. I'll assume you've seen some Terraform before, so this is a refresher, not an intro.</aside>
      </section>

      <section>
        <h3>Providers</h3>
        <p>Plugins that teach Terraform how to talk to APIs.</p>
        <pre><code class="language-hcl">provider "aws" {
  region = "us-east-1"
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}</code></pre>
        <ul>
          <li>Each provider is a separate binary, downloaded during <code>terraform init</code></li>
          <li>Version-pinned in <code>required_providers</code> block</li>
          <li>One config can use multiple providers simultaneously</li>
        </ul>
        <aside class="notes">Providers are the bridge between Terraform and the outside world. The AWS provider alone has hundreds of resource types. You can mix and match — AWS for infra, Datadog for monitoring, GitHub for repo settings, all in one config.</aside>
      </section>

      <section>
        <h3>Resources</h3>
        <p>The fundamental building block — each one maps to a real infrastructure object.</p>
        <pre><code class="language-hcl">resource "aws_s3_bucket" "logs" {
  bucket = "my-app-logs-bucket"

  tags = {
    Environment = "production"
  }
}</code></pre>
        <ul>
          <li>Format: <code>resource "TYPE" "NAME" { ... }</code></li>
          <li>Type prefix indicates the provider (<code>aws_</code>, <code>google_</code>, <code>azurerm_</code>)</li>
          <li>Terraform tracks each resource in state by its address: <code>aws_s3_bucket.logs</code></li>
        </ul>
        <aside class="notes">The type-name pair is how Terraform identifies what exists. If you rename a resource, Terraform thinks the old one should be destroyed and a new one created — unless you use moved blocks. The name is local to your config; the actual infrastructure object has its own identity in the cloud.</aside>
      </section>

      <section>
        <h3>Variables &amp; Outputs</h3>
        <pre><code class="language-hcl">variable "environment" {
  type        = string
  description = "Deployment environment"
  default     = "dev"
}

output "bucket_arn" {
  description = "ARN of the logs bucket"
  value       = aws_s3_bucket.logs.arn
}</code></pre>
        <ul>
          <li><span class="amber">Variables</span> — inputs to your config. Set via <code>-var</code>, <code>.tfvars</code> files, or env vars</li>
          <li><span class="amber">Outputs</span> — values exported after apply. Used for cross-module references and CI scripts</li>
          <li><span class="amber">Locals</span> — computed values internal to the module (like local variables)</li>
        </ul>
        <aside class="notes">Variables are the public API of a module. Outputs are the return values. Locals are private helper values. The distinction matters when you start composing modules.</aside>
      </section>

      <section>
        <h3>State</h3>
        <ul>
          <li>Terraform stores a mapping between your config and real-world resources in a <span class="amber">state file</span></li>
          <li>Default: local <code>terraform.tfstate</code> (fine for learning, not for teams)</li>
          <li>Production: <span class="green">remote backend</span> — S3 + DynamoDB for locking</li>
          <li>State contains sensitive data — treat it like a secret</li>
          <li><span class="amber">State locking</span> prevents concurrent applies from corrupting state</li>
        </ul>
        <pre><code class="language-hcl">terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}</code></pre>
        <aside class="notes">State is the most operationally important concept in Terraform. It's how Terraform knows what exists. Lose the state and you have to import everything manually. That's why remote state with locking is non-negotiable for teams. We use S3 + DynamoDB — Terragrunt manages this for us, which we'll cover later.</aside>
      </section>

      <section>
        <h3>Modules</h3>
        <ul>
          <li>A module is just a directory of <code>.tf</code> files</li>
          <li>Reusable packages of Terraform configuration</li>
          <li>Called with a <code>module</code> block, passing variables as arguments</li>
        </ul>
        <pre><code class="language-hcl">module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
}</code></pre>
        <ul>
          <li>Registry modules (like above) are community-maintained and versioned</li>
          <li>Internal modules live in your repo or a shared module repo</li>
        </ul>
        <aside class="notes">Modules are Terraform's unit of reuse. The public registry has thousands — VPC, ECS, RDS, etc. For internal use, you write your own modules that encode your company's conventions and security requirements. We use a mix of both.</aside>
      </section>
    </section>

    <!-- SLIDE 6: Writing Terraform -->
    <section>
      <section>
        <h2 class="section-header">⌨️ Writing Terraform</h2>
        <p style="color: var(--green); font-size: 0.6em;">slide.writing_terraform: Creating...</p>
        <aside class="notes">Let's look at a realistic example. Not a hello-world — something closer to what you'd actually write.</aside>
      </section>

      <section>
        <h3>A Practical Example: EC2 Instance</h3>
        <pre><code class="language-hcl">locals {
  environment = "production"
  app_name    = "api-server"

  common_tags = {
    ManagedBy   = "terraform"
    Environment = local.environment
    Application = local.app_name
  }
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance type"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the instance"
}</code></pre>
        <aside class="notes">We start with locals for values that are computed or shared across resources, and variables for values that change between environments. The common_tags pattern is something you'll see everywhere — it ensures consistent tagging.</aside>
      </section>

      <section>
        <h3>The Resource &amp; Output</h3>
        <pre><code class="language-hcl">resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.private_subnets[0]

  tags = merge(local.common_tags, {
    Name = "$${local.app_name}-$${local.environment}"
  })

  lifecycle {
    create_before_destroy = true
  }
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app.id
}

output "private_ip" {
  description = "Private IP address"
  value       = aws_instance.app.private_ip
}</code></pre>
        <aside class="notes">A few patterns to notice: we're referencing the VPC module's outputs for the subnet — that's cross-module composition. The merge() for tags combines our common tags with resource-specific ones. The lifecycle block with create_before_destroy is a common pattern for zero-downtime updates. Outputs let other modules or CI scripts grab the instance ID and IP.</aside>
      </section>
    </section>

    <!-- SLIDE 7: Terragrunt -->
    <section>
      <section>
        <h2 class="section-header">🏗️ Terragrunt</h2>
        <p style="color: var(--green); font-size: 0.6em;">slide.terragrunt: Creating...</p>
        <aside class="notes">Terragrunt is a thin wrapper around Terraform by Gruntwork. If you haven't used it, that's fine — this section covers why it exists and what it does for us. Fun fact: this very presentation is managed by Terragrunt — the module lives in modules/presentation/ and the live config passes inputs like presenter name via a terragrunt.hcl wrapper.</aside>
      </section>

      <section>
        <h3>The Problem Terragrunt Solves</h3>
        <ul>
          <li>Vanilla Terraform gets <span class="amber">repetitive</span> at scale</li>
          <li>Same backend config, same provider config, same variable patterns — copy-pasted across dozens of directories</li>
          <li>No built-in way to express <span class="amber">dependencies between stacks</span></li>
          <li>Environment promotion (dev → staging → prod) requires manual duplication</li>
        </ul>
        <p style="color: var(--green); font-size: 0.65em;">Terragrunt's motto: keep your Terraform code DRY.</p>
        <aside class="notes">When you have 5 services across 3 environments, you suddenly have 15 nearly-identical backend configs, provider blocks, and variable definitions. Terragrunt eliminates that duplication.</aside>
      </section>

      <section>
        <h3>DRY Root Modules</h3>
        <p>The core pattern: one root <code>terragrunt.hcl</code>, thin overrides per module.</p>
        <pre><code class="language-hcl"># root terragrunt.hcl
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "my-company-terraform-state"
    key            = "$${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = &lt;&lt;EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}</code></pre>
        <aside class="notes">This root config is inherited by every child module. The key uses path_relative_to_include() — that automatically namespaces state files by directory. So dev/vpc and prod/vpc get separate state files without any manual config. The generate blocks write the backend.tf and provider.tf for you — Terraform never sees Terragrunt, it just sees normal .tf files.</aside>
      </section>

      <section>
        <h3>Environment Promotion</h3>
        <pre><code class="language-bash">infrastructure/
├── terragrunt.hcl          # root config
├── dev/
│   ├── vpc/
│   │   └── terragrunt.hcl  # include root + env-specific vars
│   └── ecs/
│       └── terragrunt.hcl
├── staging/
│   ├── vpc/
│   │   └── terragrunt.hcl
│   └── ecs/
│       └── terragrunt.hcl
└── prod/
    ├── vpc/
    │   └── terragrunt.hcl
    └── ecs/
        └── terragrunt.hcl</code></pre>
        <p>Each leaf <code>terragrunt.hcl</code> is minimal:</p>
        <pre><code class="language-hcl">include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//vpc"
}

inputs = {
  environment = "dev"
  cidr_block  = "10.0.0.0/16"
}</code></pre>
        <aside class="notes">The directory structure IS the environment model. dev/vpc and prod/vpc point to the same module source — only the inputs differ. Promoting from dev to staging means copying the terragrunt.hcl and changing a few input values. The root config handles everything else: backend, providers, common settings.</aside>
      </section>

      <section>
        <h3>Remote State Management</h3>
        <ul>
          <li>Terragrunt <span class="green">auto-generates</span> the S3 backend config from the <code>remote_state</code> block</li>
          <li>State file key derived automatically from directory path</li>
          <li>Creates the S3 bucket and DynamoDB table if they don't exist</li>
          <li>No more copy-pasting backend blocks or running <code>terraform init -backend-config=...</code></li>
        </ul>
        <pre><code class="language-bash"># Without Terragrunt: manual backend in every module
# With Terragrunt: one remote_state block in root, inherited everywhere

# State paths generated automatically:
# dev/vpc/     → s3://bucket/dev/vpc/terraform.tfstate
# prod/ecs/    → s3://bucket/prod/ecs/terraform.tfstate</code></pre>
        <aside class="notes">This is one of the biggest quality-of-life wins. Backend config in vanilla Terraform can't use variables — it's one of the most painful limitations. Terragrunt works around it by generating the backend.tf file with the correct values before Terraform ever runs.</aside>
      </section>

      <section>
        <h3>Dependency Graphs</h3>
        <pre><code class="language-hcl"># ecs/terragrunt.hcl
dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id             = "vpc-mock-12345"
    private_subnet_ids = ["subnet-mock-1", "subnet-mock-2"]
  }
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

inputs = {
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.private_subnet_ids
}</code></pre>
        <ul>
          <li><span class="amber">dependency</span> blocks wire modules together — Terragrunt applies them in order</li>
          <li><span class="amber">mock_outputs</span> let you <code>plan</code> without the dependency being applied yet</li>
          <li><code>terragrunt run-all apply</code> respects the full dependency graph</li>
        </ul>
        <aside class="notes">This is the other killer feature. In vanilla Terraform, cross-stack references require remote state data sources and manual ordering. Terragrunt makes it declarative: say "I depend on VPC" and it handles the rest. mock_outputs are critical for CI — you need to be able to plan the ECS module even if the VPC hasn't been applied yet in that environment.</aside>
      </section>
    </section>

    <!-- SLIDE 8: CI/CD at Tabs -->
    <section>
      <section>
        <h2 class="section-header">🔄 CI/CD at Tabs</h2>
        <p style="color: var(--green); font-size: 0.6em;">slide.cicd_at_tabs: Creating...</p>
        <aside class="notes">Now let's talk about how this all fits into our CI/CD pipeline. Terraform in production means automated plans and gated applies.</aside>
      </section>

      <section>
        <h3>The PR Workflow</h3>
        <ul>
          <li><span class="green">On PR open / push</span> → <code>terraform plan</code> runs automatically</li>
          <li>Plan output is <span class="amber">posted as a PR comment</span> — reviewers see exactly what will change</li>
          <li>Branch protection requires plan to pass before merge</li>
          <li><span class="green">On merge to main</span> → <code>terraform apply</code> runs automatically</li>
          <li>Applies are <span class="amber">gated</span> — only main branch can apply changes</li>
        </ul>
        <br>
        <p style="color: var(--green); font-size: 0.6em; text-align: center;">PR → Plan → Review → Merge → Apply</p>
        <aside class="notes">The key principle: no one runs terraform apply from their laptop. All changes go through code review with the plan visible. This catches mistakes before they hit production. The plan-as-PR-comment pattern is standard now — it gives reviewers the same information they'd get from running plan locally.</aside>
      </section>

      <section>
        <h3>GitHub Actions Workflow</h3>
        <pre><code class="language-yaml">name: Terraform
on:
  pull_request:
    branches: [main]
  push:
    branches: [main]

jobs:
  terraform:
    runs-on: ubuntu-latest
    permissions:
      id-token: write    # OIDC auth to AWS
      contents: read
      pull-requests: write  # post plan comments

    steps:
      - uses: actions/checkout@v4

      - uses: hashicorp/setup-terraform@v3
        with:
          terraform_wrapper: false

      - uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::123456789:role/terraform-ci
          aws-region: us-east-1

      - name: Terraform Init
        run: terraform init

      - name: Terraform Plan
        if: github.event_name == 'pull_request'
        run: terraform plan -no-color -out=plan.tfplan

      - name: Post Plan to PR
        if: github.event_name == 'pull_request'
        uses: actions/github-script@v7
        with:
          script: |
            const output = require('fs')
              .readFileSync('plan.tfplan.txt', 'utf8');
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: '```\n' + output + '\n```'
            });

      - name: Terraform Apply
        if: github.ref == 'refs/heads/main'
        run: terraform apply -auto-approve</code></pre>
        <aside class="notes">A few things to note: we use OIDC for AWS auth — no static credentials stored in GitHub. The terraform_wrapper is disabled so we get clean output. The plan step saves a plan file. In reality our setup is more complex with Terragrunt and matrix strategies for multiple stacks, but this captures the core pattern. Branch protection ensures the apply step only runs after PR approval and merge.</aside>
      </section>
    </section>

    <!-- ============================================ -->
    <!-- SLIDE 9: terraform destroy — Closing         -->
    <!-- ============================================ -->
    <section>
      <h2 class="prompt">terragrunt destroy</h2>
      <br>
      <p style="text-align: center;">All resources (slides) will be destroyed.</p>
      <br>
      <p style="text-align: center; color: var(--amber); font-size: 1em;">Questions?</p>
      <br>
      <p style="text-align: center; color: #666; font-size: 0.6em;">
        This presentation will self-destruct on <code>terragrunt destroy</code>
      </p>
      <aside class="notes">
        That's it! Reminder: the source code for this presentation is literally Terraform, wrapped by Terragrunt.
        You can clone the repo and run terragrunt apply to get your own copy.
        Thanks, everyone.
      </aside>
    </section>

  HTML

  full_html = <<-FULLHTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${var.talk_title}</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/reveal.js/5.2.1/reveal.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/reveal.js/5.2.1/theme/black.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/reveal.js/5.2.1/plugin/highlight/monokai.min.css">
  <style>
${local.custom_css}
  </style>
</head>
<body>
  <div class="reveal">
    <div class="slides">
${local.slides}
    </div>
  </div>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/reveal.js/5.2.1/reveal.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/reveal.js/5.2.1/plugin/highlight/highlight.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/reveal.js/5.2.1/plugin/notes/notes.min.js"></script>
  <script>
    Reveal.initialize({
      hash: true,
      slideNumber: true,
      transition: 'none',
      width: 1200,
      height: 700,
      margin: 0.1,
      plugins: [RevealHighlight, RevealNotes]
    });
  </script>
</body>
</html>
  FULLHTML
}
