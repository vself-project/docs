workspace {

    model {
    # user agents
        user = person "User" "A user of vSelf software system."
        #dao #= person "vSelf DAO" "Team members with root level access" "DAO"
        
        # external systems
        near = softwareSystem "NEAR Blockchain" "NEAR"
        evm = softwareSystem "EVM Compatible Blockchain" "Polygon"
        filecoin = softwareSystem "Filecoin Blockchain" "IPFS & Filecoin"
        cdns = softwareSystem "Content Delivery Networks"
        
        # vself software components
        vself = softwareSystem "vSelf Software" "Cloud native digital agent and identity management tool" {
            group "Frontend" {
                
                #group "Company 1" {
                mobileApp = container "vSelf mobile application" "Allows to claim SBTs using QR-code" "Unity + App Store & Google Play" "MobileApp"
                #}
                #stores #= container "App Store & Google Play" "" 
                #testmobileApp #= component "test" "Allows to claim SBTs using QR-code" "Unity + App Store & Google Play" }
                webApp = container "vSelf Web application" "Uses for identity & community management" "Next.js & Tailwind CSS + Firabase hosting" "WebApp"
            }
            group "Cloud Layer" {
             
              vselfApp = container "vSelf API Service" "Allows authenticated interaction with vSelf Cloud services" "Next.js & tRPC + Docker & Kubernetes cluster" "API"
            }
            group "Storage Layer" {
               
                storage = container "Long-term Storage" "Stores large source files & backups" "NFT.storage & Filecoin" "Storage"
                database = container "Offline Database" "Stores user private data & identity tree" "Graph database GunDB" "Database"
                onchainstorage = container "On-chain Storage" "Stores public data of sub-identities" "NEAR Social DB" "On-chain Storage"
            }
            
            group "Backend Layer" {
                contracts = container "vSelf smart contracts" "Contains business logic & source of trust" "Rust & Solidity" "Contracts"
                indexer = container "Indexer Service" "Syncs with all the supported chains and indexes on-chain data" "The Graph Protocol & Graph QL" "Indexer"
                analytics = container "vSelf Monitoring Service" "Aggregates analitics from various sources" "Pagoda & Google Analytics & Tenderly" "Analytics"
            }
            
            
        }
        
        #inter container relationships
        webApp -> vselfApp "Uses API" "HTTPS"
        #webApp #-> mobileApp "Uses API" "HTTPS"
        #cdn #-> <mobileApp|hn> "hghg"
        mobileApp -> webApp "Interacts with" "Deep Link & Web Sockets"
        #mobileApp #-> cdns "Mobile Stores" "App Store & Google Play"
        webApp -> database "Reads from and writes to" "WebRTC"
        webApp -> storage "Writes to & reads from" "IPFS & HTPS"
        vSelfApp -> storage "Writes to & reads from" "IPFS & HTPS"
        webApp -> onchainstorage "Writes to & reads from" "near-api-js & Wallet Selector"
        vSelfApp -> onchainstorage "Writes to & reads from" "near-api-js"
        mobileApp -> vselfApp "Uses API" "HTTPS"
        #mobileApp #-> storage "Reads from" "HTTPS"
        vselfApp -> contracts "Interacts on-chain" "near-api-js & matic.js"        
        storage -> filecoin "Writes to" "Powergate API"
        indexer -> webApp "Retrieves data to" "Graph QL IDE"
        
        # container-context relationships
        indexer -> near "Read from"
       analytics -> near "Read from" "Pagoda"
       analytics -> evm "Read from" "Tenderly"
       analytics -> webApp "Read from" "Google Analytics"
        indexer -> evm "Read from"
        contracts -> near "Executed on" "Infura"
        contracts -> evm "Executed on" "Infura"
        onchainstorage -> near "Executed on" 
        user -> webApp "Interacts with"
        user -> mobileApp "Interacts with"
        user -> vSelfApp "Uses API" "HTTPS"
        #dao #-> analytics "Operates and monitors"
        #dao #-> contracts "Deploys"
        #dao #-> vselfApp "Documents and maintains cloud API"
        
        # context level relationships
        user -> vself "Uses to manage identity"
        #dao #-> near "Manages contracts"
        vself -> near "Uses as public ledger"
        vself -> filecoin "Uses as distributed storage" "Powergate API"
        #dao #-> vself "Does dev ops and decision making"
         development = deploymentEnvironment "vSelf Software" {
            deploymentNode "App Store & Google Play" {
                containerInstance mobileApp
                deploymentNode "Stores" {
                    #containerInstance stores
                }
            }
            
            deploymentNode "Docker & Kubernetes Cluster" {
                containerInstance vSelfApp
                deploymentNode "Cloud" {
                    #containerInstance stores
                }
            }
            
            deploymentNode "Firebase Hosting" {
                containerInstance webApp
                deploymentNode "Hosting" {
                    #containerInstance stores
                }
            }
        }
        
       
    }

    views {
        systemContext vself "SystemContext" {
            include *
            autoLayout
        }
        
        deployment * "vSelf Software" {
            include *
            #autoLayout lr
            }
        
        container vself {
            include *
        }

        styles {
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            
            element "Person" {
                shape person
                background #08427b
                color #ffffff
            }
            
            element "Database" {
                shape cylinder
            }
            
            element "DAO" {
                shape Robot
            }
            
            element "WebApp" {
                shape WebBrowser
            }
            
            element "MobileApp" {
                shape MobileDevicePortrait
            }

            element "Storage" {
                shape Folder
            }
            element "On-chain Storage" {
                shape Folder
            }

            element "Indexer" {
                shape RoundedBox
            }
        }
    }
    
}