Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46753345F6
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 13:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfFDLyp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 07:54:45 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:45068 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfFDLyo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 07:54:44 -0400
Received: by mail-oi1-f175.google.com with SMTP id m206so26981oib.12
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2019 04:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bEg5l0Asof3KfC/l9MfzO2g5bJAygMhd1s7uurvXf6s=;
        b=ZSnvlA4TXhy+Bmo2CmbwUR2Sb2lEBaOZNkcovWfBx3mU6VBY9AcfnYAZ2HKjTOBIfG
         qoqsqrOo5exTj+iKdO/z6OCvzsNnmE6IK2/KtOSRyIY2rDq1UDOSFiLhf+TtvELgRfrT
         DEd3V8CbVp8zvkMK1GJcI7iNX9EC2arENrg4oe98Q6JVCbkPAhSJxS5EIWvww482ebvC
         3oioybdckzm0MTyV0VP1fMqCEIsyl098rpm4Fa7D5F1xbtjt2tgG969CU2E1+xij+enW
         hTbbdl2LpYpXwSzjXBCnhpZqlxGS/6UX3Jmnt8FYNO6uyS417lKZwGnHWTJvopNEFtKd
         6/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bEg5l0Asof3KfC/l9MfzO2g5bJAygMhd1s7uurvXf6s=;
        b=CGuPLQCXVwMgBJI7ngjXnW+aQZwvWksUDXLrfp00RVChcBypHj7Sed2VDSfE9O9lUQ
         SAIR+cRU4Bw74DHzCrOoM3ekBOrtufRPDUFRkqp29K+3/wpulMhWiUmMtrEnyW8VKcxD
         ktdZO4T9E+Kgv2gdANFCf41hlLD6REHfQ3ZlRvnl3OJzrpYTpgiOmDpj6vZHVxKruhvm
         FhJAj3kRO6WD6U2eLRGzoB715b7yKEK6K5H1PFljm4t0L9gE6VO9TnmsmEtTRA8MZL9d
         auDz5hIh/ywSfBZkMZk3PQGmiWzsj5cRy8J1wAzgEe2nq8mlUat8kZT3su7PpM2lq6hA
         U/dQ==
X-Gm-Message-State: APjAAAUDyUSuJwTicxhna3lshUmU/Wgw7R1oyZ/lvEFtxmgfacGiSqYA
        Sk4iIEk0knhqjN7kzMSKAsdd5RINwG1ndOcyLlsV0p1s
X-Google-Smtp-Source: APXvYqxknX7TcEZcJ5IBgfhm51lHPFEHXjlJ6X/IPqJSvIlyUfPNohOr3dy2VGgRU8BGBs6YiyaGuogSkVnLKluXIfg=
X-Received: by 2002:aca:5c06:: with SMTP id q6mr1896617oib.63.1559649283715;
 Tue, 04 Jun 2019 04:54:43 -0700 (PDT)
MIME-Version: 1.0
From:   Vignesh Raman <vignesh.raman.in@gmail.com>
Date:   Tue, 4 Jun 2019 17:24:32 +0530
Message-ID: <CAH3OF52mbwYpJTTux2djY0wyvEwhCAEpBoTwetw8KysyJ9X-iQ@mail.gmail.com>
Subject: sd card with write-protect switch
To:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

Following is the behavior of sd card with write-protect switch on/off.
Tested in 4.14.103-rt55 debian.

When a sd card is inserted with unlocked mode (write protect switch off)
/sys/block/sda/ro is 0

When the sd card is removed and inserted with locked mode (write
protect switch on)
/sys/block/sda/ro is 1

Now again when the sd card is removed and inserted in unlocked mode,
/sys/block/sda/ro is still 1

In mmc_sd_setup_card(), after mmc_sd_get_ro() is retrived
mmc_card_set_readonly() is called if the write protect switch is
active(1).
Do we need to reset the read-only status if write protect switch is
not active(0). Any pointers will be helpful. Thanks.

Thanks.

Regards,
Vignesh
