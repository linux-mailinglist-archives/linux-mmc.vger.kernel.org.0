Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50CCCD0305
	for <lists+linux-mmc@lfdr.de>; Tue,  8 Oct 2019 23:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfJHVqR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 8 Oct 2019 17:46:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54101 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726070AbfJHVqR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Oct 2019 17:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570571176;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+eZJJqrlbPqVzOZaO5qNFGym7u5qYSToEyvJ0eC7yw=;
        b=PaF0YI7u9XNrm+wKH2nycOeefgWmyLKH0PE1eJtPHquxi0MriZdsALVql00bXfx81hBFNA
        t74f+RPjPPAXB2FyClpF2+NOt/LvH+2C4bEtwV3PxaLcFntw/7/P8ImKeYLHQtBAlY7r3Q
        Ko49UQeukWG8+Fw6ZTRPwQzObT5/xFQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-_2fugRGHM8iKUYkzBjKjZw-1; Tue, 08 Oct 2019 17:46:12 -0400
Received: by mail-io1-f72.google.com with SMTP id g15so628535ioc.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2019 14:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=R2PLCpCGC+X0FsCVNcoIrm/LGH7IA7bRES0qF3Fhu7k=;
        b=OMYG7z7H2suBwWgvXN7Wc231gaDDfYMy0Bvi3JB9YWWQiNNqIBqpX2ewqSxZfw99rE
         ScTQG5R99EvhXOIxiZWMeiQRtY770odJLciXqOef/whZ2X1OXusnnMONH4XqPp918dRg
         EYzOKfdETy8tbWyhRQM9ScN4lL56dG0hrF62LwQEfcZmgoxNXTR6+g6a11UPO77jSfEi
         oHp7bRqOkrEgdqxjF8NVjBwnTiJ3Pdh6X/Z+ZCmbV7Tvv8uimgyYLxuu63EWNZPCMJfV
         JcX0K0bG2tkwM5JLdinG2E4ifqiRwjs0eLaSHTAAAE5kXHYj3OQs/OkrnOEyAHAyAetj
         5qyg==
X-Gm-Message-State: APjAAAV/NhvBhrFZRXAyE5I/Dog9YzKoiPmkc+/WqP/kvIBE7QrE1r5F
        Fa3tHWya2ucE7TSwsvWBzSjIEDkb+GDa+5MRdys7QnEVYDuzsATBSEFe7HKwMoIym4rTGPpTwSx
        qqJ2gJaFkG/PhoCZ7k+W7
X-Received: by 2002:a02:ac8e:: with SMTP id x14mr158795jan.11.1570571172226;
        Tue, 08 Oct 2019 14:46:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzRjkZNUFsMLmBAav/k9nqbRyvIxfGbTW0hIWLHgfdTSVeQ7myWycO2xJSmj0J/txoJdC1z/Q==
X-Received: by 2002:a02:ac8e:: with SMTP id x14mr158772jan.11.1570571171801;
        Tue, 08 Oct 2019 14:46:11 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id v69sm174162ila.6.2019.10.08.14.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 14:46:11 -0700 (PDT)
Date:   Tue, 8 Oct 2019 14:46:09 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 6/6] iommu/amd: Switch to use acpi_dev_hid_uid_match()
Message-ID: <20191008214609.wk2imvejk2h2pvil@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
 <20191001142725.30857-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191001142725.30857-7-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: _2fugRGHM8iKUYkzBjKjZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue Oct 01 19, Andy Shevchenko wrote:
>Since we have a generic helper, drop custom implementation in the driver.
>
>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>---
> drivers/iommu/amd_iommu.c | 30 +++++-------------------------
> 1 file changed, 5 insertions(+), 25 deletions(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 2369b8af81f3..40f3cf44aa98 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -124,30 +124,6 @@ static struct lock_class_key reserved_rbtree_key;
>  *
>  ************************************************************************=
****/
>
>-static inline int match_hid_uid(struct device *dev,
>-=09=09=09=09struct acpihid_map_entry *entry)
>-{
>-=09struct acpi_device *adev =3D ACPI_COMPANION(dev);
>-=09const char *hid, *uid;
>-
>-=09if (!adev)
>-=09=09return -ENODEV;
>-
>-=09hid =3D acpi_device_hid(adev);
>-=09uid =3D acpi_device_uid(adev);
>-
>-=09if (!hid || !(*hid))
>-=09=09return -ENODEV;
>-
>-=09if (!uid || !(*uid))
>-=09=09return strcmp(hid, entry->hid);
>-
>-=09if (!(*entry->uid))
>-=09=09return strcmp(hid, entry->hid);
>-
>-=09return (strcmp(hid, entry->hid) || strcmp(uid, entry->uid));
>-}
>-
> static inline u16 get_pci_device_id(struct device *dev)
> {
> =09struct pci_dev *pdev =3D to_pci_dev(dev);
>@@ -158,10 +134,14 @@ static inline u16 get_pci_device_id(struct device *d=
ev)
> static inline int get_acpihid_device_id(struct device *dev,
> =09=09=09=09=09struct acpihid_map_entry **entry)
> {
>+=09struct acpi_device *adev =3D ACPI_COMPANION(dev);
> =09struct acpihid_map_entry *p;
>
>+=09if (!adev)
>+=09=09return -ENODEV;
>+
> =09list_for_each_entry(p, &acpihid_map, list) {
>-=09=09if (!match_hid_uid(dev, p)) {
>+=09=09if (acpi_dev_hid_uid_match(adev, p->hid, p->uid)) {
> =09=09=09if (entry)
> =09=09=09=09*entry =3D p;
> =09=09=09return p->devid;
>--=20
>2.23.0
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

