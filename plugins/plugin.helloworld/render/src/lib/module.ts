import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { SidebarVerticalComponent } from './views/sidebar.vertical/component';
import { PrimitiveModule } from 'chipmunk-client-material';
import * as Toolkit from 'chipmunk.client.toolkit';
import { MatButtonModule } from '@angular/material';

@NgModule({
    entryComponents: [ SidebarVerticalComponent],
    declarations: [ SidebarVerticalComponent],
    imports: [ CommonModule, FormsModule, PrimitiveModule, MatButtonModule ],
    exports: [ SidebarVerticalComponent]
})

export class PluginModule extends Toolkit.PluginNgModule {

    constructor() {
        super('OS', 'Allows to execute local processes');
    }

}
