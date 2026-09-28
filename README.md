# Azure AZ-104 Infrastructure as Code (IaC) with Bicep

This repository contains my personal project for building and managing Azure infrastructure using **Azure Bicep modules**, aligned with the **AZ-104: Microsoft Azure Administrator** certification topics. 

The goal of this project is to practice and demonstrate modular Infrastructure as Code (IaC) principles for better management, scalability, and reusability.

## 🏗️ Architecture & Modules

The project is structured into reusable modules located in the `modules` directory:

*   **Bastion (`bastion.bicep`)**: Deploys Azure Bastion for secure, seamless RDP/SSH connectivity to virtual machines.
*   **Network (`network/`)**:
    *   `internalVnet.bicep`: Configures the core internal Virtual Network and subnets.
    *   `vnetPeering.bicep`: Sets up VNet peering to connect different virtual networks.
    *   `vnetTest.bicep`: A testing environment network topology.
*   **Network Security Group (`nsg/`)**:
    *   `nsg.bicep`: Defines security rules to control inbound and outbound traffic.
*   **Storage (`storage.bicep`)**: Deploys Azure Storage Accounts.
*   **Virtual Machines (`vm/`)**:
    *   `vm.bicep`: Creates and configures Azure Virtual Machines (Windows/Linux).
    *   `vnetTest.bicep`: Integrates test VMs with the virtual networks.
*   **`params/dev.parameters.bicepparam`**: Contains the actual deployment values and configuration data for the development environment.
*   **`main.bicep`**: Acts as the central orchestrator. It receives the values from the `.bicepparam` file and forwards them to the resource modules.

## 🚀 Getting Started

### Prerequisites
*   An active **Azure Subscription**.
*   **Azure CLI** (installed and updated).
*   **Bicep CLI** or the VS Code Bicep extension.


## 🛠️ Tools Used
*   **Azure Bicep** - Declarative syntax for deploying Azure resources.
*   **Azure CLI** - Command-line tool for managing Azure resources.
*   **VS Code** - Code editor with Bicep extensions for validation and syntax highlighting.
