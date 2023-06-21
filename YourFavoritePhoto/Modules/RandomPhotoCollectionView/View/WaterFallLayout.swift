//
//  WaterFallLayout.swift
//  YourFavoritePhoto
//
//  Created by Лидия Ладанюк on 20.06.2023.
//

import UIKit

protocol WaterFallLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath indexPath: IndexPath) -> CGSize
}

class WaterFallLayout: UICollectionViewLayout {

    weak var delegate: WaterFallLayoutDelegate?
    
    ///Количество столбцов
    private var numberOfColumns = 2
    
    ///Заполнение ячейки
    private let cellPadding: CGFloat = 0
    
    ///Массив для кеширования вычесляемых атрибутов
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    ///Высота содержимого
    private var contentHeight: CGFloat = 0
    
    ///Вычисление ширины на основе ширины представления и ее содержимого
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return collectionView.bounds.width
    }
    
    ///Размер содержимого представления коллекции
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        super.prepare()
        //Если кеш пусты, вычисляем атрибуты макета
        guard cache.isEmpty, let collectionView = collectionView else { return }
        
        ///Ширина столбца
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        
        ///Массив координат x
        var xOffset: [CGFloat] = []
        
        //Заполняем массив для каждого столбца на основе шиниры столбца
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        
        ///Массив отслеживает положение по оси Y для каждого столбца
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let photoSize = delegate?.collectionView(collectionView, sizeForPhotoAtIndexPath: indexPath)
            let cellWidth = columnWidth
            var cellHeight = (photoSize?.height ?? 180) * cellWidth / (photoSize?.width ?? 180)
            cellHeight = cellPadding * 2 + cellHeight
            
            
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: cellWidth, height: cellHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            //Устанавливаем фрейм CollectionViewLayoutAttributes
            attributes.frame = insetFrame
            
            //Добавляем атрибуты в кеш
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            //Увеличиваем yOffset для текущего столбца в зависимости от кадра
            yOffset[column] = yOffset[column] + cellHeight
            
            if numberOfColumns > 1 {
                var isColumnChanged = false
                for index in (1..<numberOfColumns).reversed() {
                    if yOffset[index] >= yOffset[index - 1] {
                        column = index - 1
                        isColumnChanged = true
                    }
                    else {
                        break
                    }
                }
                
                if isColumnChanged {
                    continue
                }
            }
            
            //Перемещаем столбец вперед, чтобы следующий элемент был помещен в следующий столбец.
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        ///Извлекаем и возвращаем из кеша атрибуты макета, соответствующие запрошенному indexPath
        return cache[indexPath.item]
    }


}
