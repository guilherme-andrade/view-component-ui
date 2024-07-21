import { config, library, dom } from '@fortawesome/fontawesome-svg-core'
import { fas } from '@fortawesome/free-solid-svg-icons'
import "./main.css";
import "./channels/compiler_channel";

import Alpine from "alpinejs";

(window as any).Alpine = Alpine;

config.mutateApproach = 'sync'

Alpine.start();
library.add(fas)
dom.watch()
